import 'package:easy_localization/easy_localization.dart';
import 'package:employees_app/domain/models/employee/employee.dart';
import 'package:employees_app/presentation/pages/employee_detail/widgets/employee_detail_cell.dart';
import 'package:employees_app/presentation/providers/employee_detail_provider.dart';
import 'package:employees_app/presentation/providers/employees_provider.dart';
import 'package:employees_app/presentation/style/fonts.dart';
import 'package:employees_app/presentation/style/spacings.dart';
import 'package:employees_app/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmployeeDetailPage extends ConsumerWidget {
  const EmployeeDetailPage({super.key, required this.employeeId});

  final int employeeId;

  //
  // Actions
  //

  void _presentEmployeeDetailEdit(BuildContext context, Employee employee) {
    context.push('/employee/${employee.id}/edit');
  }

  void _deleteEmployee(BuildContext context, WidgetRef ref) {
    context.pop();
    ref.read(employeesProvider.notifier).deleteEmployee(employeeId);
  }

  //
  // UI
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Employee? employee = ref.watch(employeeDetailProvider(employeeId));
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('employeeDetail.title'))),
      body: Padding(
        padding: AppSpacing.screenPaddingHorizontal,
        child: employee != null
            ? _buildEmployeeDetail(context, ref, employee)
            : _buildNotFoundError(context),
      ),
    );
  }

  Widget _buildEmployeeDetail(
    BuildContext context,
    WidgetRef ref,
    Employee employee,
  ) {
    return Column(
      spacing: AppSpacing.sectionSpacing,
      crossAxisAlignment: .stretch,
      children: [
        EmployeeDetailCell(employee: employee),
        Row(
          spacing: AppSpacing.m,
          children: [
            Expanded(
              child: AppButton(
                text: context.tr('employeeDetail.delete'),
                onPressed: () => _deleteEmployee(context, ref),
                destructive: true,
              ),
            ),
            Expanded(
              child: AppButton(
                text: context.tr('employeeDetail.edit'),
                onPressed: () => _presentEmployeeDetailEdit(context, employee),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotFoundError(BuildContext context) {
    return Center(
      child: Text(
        context.tr('employeeDetail.notFound'),
        style: AppFonts.text.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
