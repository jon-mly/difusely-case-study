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
  final int id;
  @override
  final String employeeName;
  @override
  @JsonKey(fromJson: _parseStringToDouble, toJson: _parseDoubleToString)
  final double employeeSalary;
  @override
  @JsonKey(fromJson: _parseStringToInt, toJson: _parseIntToString)
  final int employeeAge;
  @override
  final String profileImage;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

double _parseStringToDouble(String value) => double.parse(value);
String _parseDoubleToString(double value) => value.toString();
int _parseStringToInt(String value) => int.parse(value);
String _parseIntToString(int value) => value.toString();
