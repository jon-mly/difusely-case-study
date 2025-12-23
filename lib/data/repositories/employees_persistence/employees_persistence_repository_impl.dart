import 'package:employees_app/core/local_db/local_db.dart';
import 'package:employees_app/domain/models/employee/employee.dart';
import 'package:employees_app/domain/repositories/employees_persistence/employees_persistence_repository.dart';
import 'package:sembast/sembast.dart';

class EmployeesPersistenceRepositoryImpl
    implements EmployeesPersistenceRepository {
  static const String _keyName = 'employees';

  final _store = StoreRef<String, Map<String, dynamic>>.main();

  @override
  Future<List<Employee>> getAllEmployees() async {
    final Database db = await LocalDatabase.instance.database;
    final Map<String, dynamic>? json = await _store.record(_keyName).get(db);
    // Static analysis identifies the list as List<dynamic> when using .map.
    // for-loop is forced.
    final List<Employee> employees = [];
    for (final map in json?['employees'] ?? []) {
      employees.add(Employee.fromJson(map));
    }
    return employees;
  }

  @override
  Future<void> saveEmployees(List<Employee> employees) async {
    final Database db = await LocalDatabase.instance.database;
    await _store.record(_keyName).put(db, {
      'employees': employees.map((e) => e.toJson()).toList(),
    });
  }
}
