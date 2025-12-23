import 'package:employees_app/domain/models/employee/employee.dart';
import 'package:employees_app/domain/models/employee_edit/employee_edit.dart';
import 'package:employees_app/domain/repositories/employees_api/employees_repository.dart';

class EmployeeService {
  final EmployeesRepository _employeesRepository;

  EmployeeService(this._employeesRepository);

  Future<List<Employee>> getAllEmployees() async =>
      _employeesRepository.getAllEmployees();

  Future<Employee?> getEmployeeById(String id) async =>
      _employeesRepository.getEmployeeById(id);

  Future<int> createEmployee(EmployeeEdit employeeEdit) async =>
      _employeesRepository.createEmployee(employeeEdit);

  Future<void> updateEmployee(int id, EmployeeEdit employeeEdit) async =>
      _employeesRepository.updateEmployee(id, employeeEdit);

  Future<void> deleteEmployee(int id) async =>
      _employeesRepository.deleteEmployee(id);
}
