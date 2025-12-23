import 'package:employees_app/domain/models/employee/employee.dart';

abstract class EmployeesRepository {
  Future<List<Employee>> getAllEmployees();
  Future<Employee?> getEmployeeById(String id);
  Future<int?> createEmployee(Employee employee);
  Future<void> updateEmployee(Employee employee);
  Future<void> deleteEmployee(int id);
}
