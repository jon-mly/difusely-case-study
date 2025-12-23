import 'package:employees_app/presentation/pages/employee_detail/employee_detail_page.dart';
import 'package:employees_app/presentation/pages/employees_list/employees_list_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/employees',
  routes: [
    GoRoute(
      path: '/employees',
      builder: (context, state) => const EmployeesListPage(),
    ),
    GoRoute(
      path: '/employee/:id',
      builder: (context, state) => EmployeeDetailPage(
        employeeId: int.parse(state.pathParameters['id']!),
      ),
    ),
  ],
);
