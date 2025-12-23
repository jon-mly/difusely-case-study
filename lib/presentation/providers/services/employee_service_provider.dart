import 'package:employees_app/data/repositories/employees_api/employees_repository_impl.dart';
import 'package:employees_app/data/repositories/employees_api/employees_repository_mock.dart';
import 'package:employees_app/domain/services/employee_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<EmployeeService> employeeServiceProvider = .new((ref) {
  return EmployeeService(EmployeesRepositoryMock());
  // return EmployeeService(EmployeesRepositoryImpl());
});
