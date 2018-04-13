// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth2_helper.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

TokenResults _$TokenResultsFromJson(Map<String, dynamic> json) =>
    new TokenResults(
        json['access_token'] as String,
        json['token_type'] as String,
        json['user'] == null
            ? null
            : new User.fromJson(json['user'] as Map<String, dynamic>),
        json['expires_in'] as int);

abstract class _$TokenResultsSerializerMixin {
  String get accessToken;
  String get tokenType;
  User get user;
  int get expiresIn;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'access_token': accessToken,
        'token_type': tokenType,
        'user': user,
        'expires_in': expiresIn
      };
}

User _$UserFromJson(Map<String, dynamic> json) =>
    new User(json['id'] as int, json['name'] as String);

abstract class _$UserSerializerMixin {
  int get id;
  String get name;
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};
}
