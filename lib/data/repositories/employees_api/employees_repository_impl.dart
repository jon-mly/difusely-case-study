import 'package:employees_app/domain/models/employee/employee.dart';
import 'package:employees_app/domain/repositories/employees_api/employees_repository.dart';
import 'package:dio/dio.dart';

class EmployeesRepositoryImpl implements EmployeesRepository {
  static final String _baseUrl = 'https://dummy.restapiexample.com/api/v1';

  @override
  Future<List<Employee>> getAllEmployees() async {
    final Response response = await Dio().get('$_baseUrl/employees');
    if (response.statusCode == 200 && response.data['status'] == 'success') {
      return response.data['data'].map((item) {
        return Employee.fromJson(item);
      }).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }

  @override
  Future<Employee?> getEmployeeById(String id) async {
    final Response response = await Dio().get('$_baseUrl/employee/$id');
    if (response.statusCode == 200 && response.data['status'] == 'success') {
      return Employee.fromJson(response.data.data);
    } else {
      throw Exception('Failed to load employee');
    }
  }

  @override
  Future<int?> createEmployee(Employee employee) async {
    final Map<String, dynamic> creationData = {
      'name': employee.employeeName,
      'salary': employee.employeeSalary,
      'age': employee.employeeAge,
    };
    final Response response = await Dio().post(
      '$_baseUrl/create',
      data: creationData,
    );
    if (response.statusCode == 200 && response.data['status'] == 'success') {
      return response.data['data']?['id'];
    } else {
      throw Exception('Failed to create employee');
    }
  }

  // TODO: is not exactly json from employee but specific name fields
  @override
  Future<void> updateEmployee(Employee employee) async =>
      throw UnimplementedError();

  @override
  Future<void> deleteEmployee(int id) async {
    final Response response = await Dio().delete('$_baseUrl/delete/$id');
    if (response.statusCode == 200 && response.data['status'] == 'success') {
      return;
    } else {
      throw Exception('Failed to delete employee');
    }
  }
}
