import 'package:employees_app/domain/models/employee/employee.dart';
import 'package:employees_app/domain/models/employee_edit/employee_edit.dart';

abstract class EmployeesRepository {
  Future<List<Employee>> getAllEmployees();
  Future<Employee?> getEmployeeById(String id);
  Future<int> createEmployee(EmployeeEdit employeeEdit);
  Future<void> updateEmployee(int id, EmployeeEdit employeeEdit);
  Future<void> deleteEmployee(int id);
}
