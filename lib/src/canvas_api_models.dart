import 'package:json_annotation/json_annotation.dart';

part 'canvas_api_models.g.dart';

@JsonSerializable()
class ExternalTool extends Object with _$ExternalToolSerializerMixin {
  final String domain;
  final String url;

  ExternalTool(this.domain, this.url);

  factory ExternalTool.fromJson(Map<String, dynamic> json) => _$ExternalToolFromJson(json);
}

@JsonSerializable()
class SessionlessLaunchDetails extends Object with _$SessionlessLaunchDetailsSerializerMixin {
  final int id;
  final String name;
  final String url;

  SessionlessLaunchDetails(this.id, this.name, this.url);

  factory SessionlessLaunchDetails.fromJson(Map<String, dynamic> json) => _$SessionlessLaunchDetailsFromJson(json);
}

@JsonSerializable()
class Account extends Object with _$AccountSerializerMixin {
  final int id;

  Account(this.id);

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}

@JsonSerializable()
class Course extends Object with _$CourseSerializerMixin {
  final int id;

  Course(this.id);

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}