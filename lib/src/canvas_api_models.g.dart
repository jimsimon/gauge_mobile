// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_api_models.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

ExternalTool _$ExternalToolFromJson(Map<String, dynamic> json) =>
    new ExternalTool(json['domain'] as String, json['url'] as String);

abstract class _$ExternalToolSerializerMixin {
  String get domain;
  String get url;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'domain': domain, 'url': url};
}

SessionlessLaunchDetails _$SessionlessLaunchDetailsFromJson(
        Map<String, dynamic> json) =>
    new SessionlessLaunchDetails(
        json['id'] as int, json['name'] as String, json['url'] as String);

abstract class _$SessionlessLaunchDetailsSerializerMixin {
  int get id;
  String get name;
  String get url;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'name': name, 'url': url};
}

Account _$AccountFromJson(Map<String, dynamic> json) =>
    new Account(json['id'] as int);

abstract class _$AccountSerializerMixin {
  int get id;
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id};
}

Course _$CourseFromJson(Map<String, dynamic> json) =>
    new Course(json['id'] as int);

abstract class _$CourseSerializerMixin {
  int get id;
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id};
}
