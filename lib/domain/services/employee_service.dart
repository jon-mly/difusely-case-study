import 'package:employees_app/domain/models/employee/employee.dart';
import 'package:employees_app/domain/repositories/employees_api/employees_repository.dart';

// TODO: add caching system upon request results
// TODO: add error handling

class EmployeeService {
  final EmployeesRepository _employeesRepository;

  EmployeeService(this._employeesRepository);

  Future<List<Employee>> getAllEmployees() async =>
      _employeesRepository.getAllEmployees();

  Future<Employee?> getEmployeeById(String id) async =>
      _employeesRepository.getEmployeeById(id);

  Future<int?> createEmployee(Employee employee) async =>
      _employeesRepository.createEmployee(employee);

  Future<void> updateEmployee(Employee employee) async =>
      _employeesRepository.updateEmployee(employee);

  Future<void> deleteEmployee(int id) async =>
      _employeesRepository.deleteEmployee(id);
}
