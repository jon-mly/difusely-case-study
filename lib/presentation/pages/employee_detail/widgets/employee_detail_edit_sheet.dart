import 'package:flutter/material.dart';

class EmployeeDetailEditSheet extends StatefulWidget {
  const EmployeeDetailEditSheet({super.key});

  @override
  State<EmployeeDetailEditSheet> createState() =>
      _EmployeeDetailEditSheetState();
}

class _EmployeeDetailEditSheetState extends State<EmployeeDetailEditSheet> {
  final TextEditingController nameController = .new();
  final TextEditingController salaryController = .new();
  final TextEditingController ageController = .new();

  //
  // Lifecycle
  //

  @override
  void dispose() {
    nameController.dispose();
    salaryController.dispose();
    ageController.dispose();
    super.dispose();
  }

  //
  // UI
  //

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
