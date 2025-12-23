import 'package:easy_localization/easy_localization.dart';
import 'package:employees_app/domain/models/employee/employee.dart';
import 'package:employees_app/domain/models/employee_edit/employee_edit.dart';
import 'package:employees_app/presentation/style/fonts.dart';
import 'package:employees_app/presentation/style/radius.dart';
import 'package:employees_app/presentation/style/spacings.dart';
import 'package:employees_app/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class EmployeeDetailEditDialog extends StatefulWidget {
  const EmployeeDetailEditDialog({
    super.key,
    required this.initialEmployee,
    required this.onEmployeeUpdated,
  });

  final Employee? initialEmployee;
  final Function(EmployeeEdit) onEmployeeUpdated;

  static void show(
    BuildContext context,
    Employee? initialEmployee,
    Function(EmployeeEdit) onEmployeeUpdated,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => EmployeeDetailEditDialog(
        initialEmployee: initialEmployee,
        onEmployeeUpdated: onEmployeeUpdated,
      ),
    );
  }

  @override
  State<EmployeeDetailEditDialog> createState() =>
      _EmployeeDetailEditDialogState();
}

class _EmployeeDetailEditDialogState extends State<EmployeeDetailEditDialog> {
  final GlobalKey<FormState> _formKey = .new();
  final TextEditingController _nameController = .new();
  final TextEditingController _salaryController = .new();
  final TextEditingController _ageController = .new();

  //
  // Lifecycle
  //

  @override
  void initState() {
    _nameController.text = widget.initialEmployee?.employeeName ?? '';
    _salaryController.text =
        widget.initialEmployee?.employeeSalary.toString() ?? '';
    _ageController.text = widget.initialEmployee?.employeeAge.toString() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _salaryController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  //
  // Actions
  //

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onEmployeeUpdated(
      EmployeeEdit(
        name: _nameController.text.trim(),
        salary: int.parse(_salaryController.text),
        age: int.parse(_ageController.text),
      ),
    );
    context.pop();
  }

  //
  // UI
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.shadow.withAlpha(30),
      body: Center(
        child: Padding(
          padding: AppSpacing.screenPaddingAll,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: AppRadius.cardBorderRadius,
            ),
            padding: AppSpacing.cardPaddingAll,
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: .min,
        children: [
          Text(
            widget.initialEmployee == null
                ? context.tr('employeeDetail.editDialog.titleCreation')
                : context.tr('employeeDetail.editDialog.title'),
            style: AppFonts.h2,
          ),
          AppSpacing.verticalM,
          TextFormField(
            controller: _nameController,
            decoration: .new(
              labelText: context.tr('employeeDetail.editDialog.nameLabel'),
            ),
            validator: (v) => v == null || v.trim().isEmpty
                ? context.tr('employeeDetail.edit.nameValidator')
                : null,
          ),
          AppSpacing.verticalS,
          TextFormField(
            controller: _salaryController,
            decoration: .new(
              labelText: context.tr('employeeDetail.editDialog.salaryLabel'),
              suffixText: '€',
            ),
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (v) =>
                (v == null || v.isEmpty || double.tryParse(v) == null)
                ? context.tr('employeeDetail.editDialog.salaryValidator')
                : null,
          ),
          AppSpacing.verticalS,
          TextFormField(
            controller: _ageController,
            decoration: .new(
              labelText: context.tr('employeeDetail.editDialog.ageLabel'),
            ),
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (v) =>
                (v == null || v.isEmpty || int.tryParse(v) == null)
                ? context.tr('employeeDetail.editDialog.ageValidator')
                : null,
          ),
          AppSpacing.verticalM,
          AppButton(
            text: context.tr('employeeDetail.editDialog.save'),
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}
