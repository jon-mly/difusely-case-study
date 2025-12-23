import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

@freezed
@JsonSerializable()
class Employee with _$Employee {
  const Employee({
    required this.id,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge,
    required this.profileImage,
  });

  @override
  final int? id;
  @override
  @JsonKey(name: "employee_name")
  final String? employeeName;
  @override
  @JsonKey(
    name: "employee_salary",
    fromJson: _parseStringToInt,
    toJson: _parseIntToString,
  )
  final int? employeeSalary;
  @override
  @JsonKey(
    name: "employee_age",
    fromJson: _parseStringToInt,
    toJson: _parseIntToString,
  )
  final int? employeeAge;
  @override
  @JsonKey(name: "profile_image")
  final String? profileImage;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  bool get isPending => id == null;
}

int? _parseStringToInt(String? value) =>
    value != null ? int.parse(value) : null;

String? _parseIntToString(int? value) => value?.toString();
