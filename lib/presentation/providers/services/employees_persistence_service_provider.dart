import 'package:employees_app/data/repositories/employees_persistence/employees_persistence_repository_impl.dart';
import 'package:employees_app/domain/services/employee_persistence_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<EmployeePersistenceService> employeesPersistenceServiceProvider =
    .new((ref) {
      return EmployeePersistenceService(EmployeesPersistenceRepositoryImpl());
    });
