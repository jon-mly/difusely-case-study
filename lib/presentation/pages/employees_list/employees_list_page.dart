import 'package:easy_localization/easy_localization.dart';
import 'package:employees_app/domain/models/employee/employee.dart';
import 'package:employees_app/domain/models/employee_edit/employee_edit.dart';
import 'package:employees_app/domain/models/sync/sync_data.dart';
import 'package:employees_app/presentation/pages/dialogs/employee_detail_edit_dialog.dart';
import 'package:employees_app/presentation/pages/dialogs/error_dialog.dart';
import 'package:employees_app/presentation/pages/employees_list/widgets/employee_cell.dart';
import 'package:employees_app/presentation/pages/employees_list/widgets/employee_loading_cell.dart';
import 'package:employees_app/presentation/providers/employees_provider.dart';
import 'package:employees_app/presentation/style/fonts.dart';
import 'package:employees_app/presentation/style/spacings.dart';
import 'package:employees_app/presentation/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmployeesListPage extends ConsumerStatefulWidget {
  const EmployeesListPage({super.key});

  @override
  ConsumerState<EmployeesListPage> createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends ConsumerState<EmployeesListPage> {
  @override
  void initState() {
    super.initState();
    _fetchRemoteEmployees();
  }

  Future<void> _fetchRemoteEmployees() async {
    try {
      await ref.read(employeesProvider.notifier).fetchEmployeesRemote();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.tr('error.fetchEmployees')),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  //
  // Actions
  //

  void _presentEmployeeDetail(BuildContext context, Employee employee) {
    context.push('/employee/${employee.id}');
  }

  void _presentEmployeeCreate(BuildContext context, WidgetRef ref) {
    EmployeeDetailEditDialog.show(context, null, (
      EmployeeEdit employeeEdit,
    ) async {
      try {
        await ref.read(employeesProvider.notifier).createEmployee(employeeEdit);
      } catch (e) {
        if (context.mounted) {
          ErrorDialog.show(context, context.tr('error.createEmployee'));
        }
      }
    });
  }

  //
  // UI
  //

  @override
  Widget build(BuildContext context) {
    final AsyncValue<SyncData<List<Employee>>> employeesValue = ref.watch(
      employeesProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('employees.title'), style: AppFonts.h1),
      ),
      body: employeesValue.when(
        data: (SyncData<List<Employee>> employeesData) =>
            _buildPageBody(context, employeesData),
        error: (error, stackTrace) => _buildError(context, error),
        loading: () => _buildLoading(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _presentEmployeeCreate(context, ref),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: .endDocked,
    );
  }

  Widget _buildPageBody(
    BuildContext context,
    SyncData<List<Employee>> employeesData,
  ) {
    final DataSource dataSource = employeesData.source;
    return Column(
      spacing: AppSpacing.m,
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: AppSpacing.screenPaddingHorizontal,
          child: StatusChip(
            text: context.tr(dataSource.locKey),
            color: dataSource == .local
                ? Colors.grey
                : Theme.of(context).colorScheme.primary,
          ),
        ),
        Expanded(child: _buildEmployeesList(context, employeesData.data)),
      ],
    );
  }

  Widget _buildEmployeesList(BuildContext context, List<Employee> employees) {
    return RefreshIndicator.adaptive(
      onRefresh: _fetchRemoteEmployees,
      child: employees.isEmpty
          // Empty list embedded in a scrollable widget to enable pull-to-refresh
          ? CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  child: Center(
                    child: Text(context.tr('employees.list.empty')),
                  ),
                ),
              ],
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: employees.length,
              padding: AppSpacing.screenPaddingHorizontal,
              separatorBuilder: (_, _) => AppSpacing.verticalM,
              itemBuilder: (context, index) => EmployeeCell(
                employee: employees[index],
                onTap: () => _presentEmployeeDetail(context, employees[index]),
              ),
            ),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Padding(
      padding: AppSpacing.screenPaddingAll,
      child: Center(child: Text(error.toString())),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Padding(
      padding: AppSpacing.screenPaddingHorizontal,
      child: Column(
        spacing: AppSpacing.sectionSpacing,
        mainAxisAlignment: .start,
        children: [
          Column(
            spacing: AppSpacing.m,
            children: List.generate(3, (index) => const EmployeeLoadingCell()),
          ),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
