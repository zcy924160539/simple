import 'package:simple/generated/json/base/json_field.dart';
import 'package:simple/generated/json/student_data_bean.g.dart';
import 'dart:convert';
export 'package:simple/generated/json/student_data_bean.g.dart';

@JsonSerializable()
class StudentDataBean {
	int? type;
	String? id;
	List<StudentDataStudentList>? studentList;

	StudentDataBean();

	factory StudentDataBean.fromJson(Map<String, dynamic> json) => $StudentDataBeanFromJson(json);

	Map<String, dynamic> toJson() => $StudentDataBeanToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class StudentDataStudentList {
	String? name;
	int? age;
	String? sId;

	StudentDataStudentList();

	factory StudentDataStudentList.fromJson(Map<String, dynamic> json) => $StudentDataStudentListFromJson(json);

	Map<String, dynamic> toJson() => $StudentDataStudentListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}