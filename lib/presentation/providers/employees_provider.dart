import 'package:employees_app/domain/models/employee/employee.dart';
import 'package:employees_app/domain/models/employee_edit/employee_edit.dart';
import 'package:employees_app/domain/models/sync/sync_data.dart';
import 'package:employees_app/presentation/providers/services/employee_service_provider.dart';
import 'package:employees_app/presentation/providers/services/employees_persistence_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AsyncNotifierProvider<EmployeesNotifier, SyncData<List<Employee>>>
employeesProvider = .new(EmployeesNotifier.new);

class EmployeesNotifier extends AsyncNotifier<SyncData<List<Employee>>> {
  EmployeesNotifier();

  @override
  Future<SyncData<List<Employee>>> build() async {
    final List<Employee> localEmployees = await ref
        .read(employeesPersistenceServiceProvider)
        .getAllEmployees();
    return SyncData(data: localEmployees, source: .local);
  }

  Future<void> fetchEmployeesRemote() async {
    final List<Employee> originalList = state.value?.data ?? [];
    try {
      final List<Employee> remoteEmployees = await ref
          .read(employeeServiceProvider)
          .getAllEmployees();
      await ref
          .read(employeesPersistenceServiceProvider)
          .saveEmployees(remoteEmployees);
      _updateState(SyncData(data: remoteEmployees, source: .remote));
    } catch (e) {
      print(e);
      _updateState(SyncData(data: originalList, source: .local));
      rethrow;
    }
  }

  Future<void> createEmployee(EmployeeEdit employeeEdit) async {
    final List<Employee> originalList = state.value?.data ?? [];

    try {
      final Employee newEmployee = Employee(
        id: null,
        employeeName: employeeEdit.name,
        employeeSalary: employeeEdit.salary,
        employeeAge: employeeEdit.age,
        profileImage: '',
      );
      final List<Employee> newList = List<Employee>.from(originalList);
      newList.add(newEmployee);
      final int newEmployeeIndex = newList.length - 1;
      _updateState(SyncData(data: newList, source: .local));
      final int newEmployeeId = await ref
          .read(employeeServiceProvider)
          .createEmployee(employeeEdit);
      newList[newEmployeeIndex] = newEmployee.copyWith(id: newEmployeeId);
      _updateState(SyncData(data: newList, source: .remote));
    } catch (e) {
      _updateState(SyncData(data: originalList, source: .local));
      rethrow;
    }
  }

  Future<void> updateEmployee(int id, EmployeeEdit employeeEdit) async {
    final List<Employee> originalList = state.value?.data ?? [];

    try {
      final List<Employee> newList = List<Employee>.from(originalList);
      final int index = newList.indexWhere((e) => e.id == id);
      if (index == -1) {
        throw Exception('Employee not found');
      }
      final Employee edited = newList[index].copyWith(
        employeeName: employeeEdit.name,
        employeeSalary: employeeEdit.salary,
        employeeAge: employeeEdit.age,
      );
      newList[index] = edited;
      _updateState(SyncData(data: newList, source: .local));
      await ref.read(employeeServiceProvider).updateEmployee(id, employeeEdit);
      _updateState(SyncData(data: newList, source: .remote));
    } catch (e) {
      _updateState(SyncData(data: originalList, source: .local));
      rethrow;
    }
  }

  Future<void> deleteEmployee(int id) async {
    final List<Employee> originalList = state.value?.data ?? [];

    try {
      final List<Employee> newList = originalList
          .where((e) => e.id != id)
          .toList();
      _updateState(SyncData(data: newList, source: .local));
      await ref.read(employeeServiceProvider).deleteEmployee(id);
      _updateState(SyncData(data: newList, source: .remote));
    } catch (e) {
      _updateState(SyncData(data: originalList, source: .local));
      rethrow;
    }
  }

  void _updateState(SyncData<List<Employee>> syncData) {
    state = .data(syncData);
    if (syncData.source == .remote) {
      ref
          .read(employeesPersistenceServiceProvider)
          .saveEmployees(syncData.data);
    }
  }
}
