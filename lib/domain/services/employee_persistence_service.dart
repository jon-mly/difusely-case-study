import 'package:employees_app/domain/models/employee/employee.dart';
import 'package:employees_app/domain/repositories/employees_persistence/employees_persistence_repository.dart';

class EmployeePersistenceService {
  final EmployeesPersistenceRepository _employeesPersistenceRepository;

  EmployeePersistenceService(this._employeesPersistenceRepository);

  Future<List<Employee>> getAllEmployees() async =>
      _employeesPersistenceRepository.getAllEmployees();

  Future<void> saveEmployees(List<Employee> employees) async =>
      _employeesPersistenceRepository.saveEmployees(employees);
}
