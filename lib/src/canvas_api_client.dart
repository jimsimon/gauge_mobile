import 'dart:async';
import 'dart:convert';
import 'package:gauge_flutter_app/src/canvas_api_models.dart';
import 'package:http_client/http_client.dart';

abstract class CanvasApiClient {
  final String shard;

  Client get client;

  CanvasApiClient(this.shard);

  get baseUrl => 'https://$shard.instructure.com/api/v1';

  Future<List<Account>> getAccounts(token) async {
    List json = await _makeJsonRequest(token, '/accounts');
    return json.map((entry) => new Account.fromJson(entry)).toList();
  }

  Future<List<Course>> getCoursesForUser(token, userId) async {
    List json = await _makeJsonRequest(token, '/users/$userId/courses');
    return json.map((entry) => new Course.fromJson(entry)).toList();
  }

  Future<List<ExternalTool>> getExternalToolsForAccount(token) async {
    List json = await _makeJsonRequest(token, '/accounts/self/external_tools');
    return json.map((entry) => new ExternalTool.fromJson(entry)).toList();
  }

  Future<List<ExternalTool>> getExternalToolsForCourse(token, courseId, {includeParents = false}) async {
    List json = await _makeJsonRequest(token, '/courses/$courseId/external_tools?include_parents=$includeParents');
    return json.map((entry) => new ExternalTool.fromJson(entry)).toList();
  }

  Future<SessionlessLaunchDetails> getExternalToolSessionlessLaunchDetailsForCourse(token, courseId, ltiLaunchUrl) async {
    var json = await _makeJsonRequest(token, '/courses/$courseId/external_tools/sessionless_launch?url=$ltiLaunchUrl');
    return new SessionlessLaunchDetails.fromJson(json);
  }

  Future<SessionlessLaunchDetails> getExternalToolSessionlessLaunchDetailsForAccount(token, ltiLaunchUrl) async {
    var json = await _makeJsonRequest(token, '/accounts/self/external_tools/sessionless_launch?url=$ltiLaunchUrl');
    return new SessionlessLaunchDetails.fromJson(json);
  }

  _makeRequest(token, url) async {
    var requestUrl = baseUrl + url;
    final response = await client.send(new Request('GET', requestUrl,
        headers: new Headers({'Authorization': 'Bearer $token'})));
    await client.close();

    if (response.statusCode < 200 || response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.reasonPhrase);
    }

    return await response.readAsString();
  }

  _makeJsonRequest(token, url) async {
    var jsonString = await _makeRequest(token, url);
    return json.decode(jsonString);
  }
}

class ApiException {
  final int statusCode;
  final String reasonPhrase;

  ApiException(this.statusCode, this.reasonPhrase);

  @override
  String toString() {
    return 'Bad API Response: $statusCode - $reasonPhrase';
  }
}
