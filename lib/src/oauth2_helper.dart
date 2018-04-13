import 'dart:async';
import 'dart:convert';
import 'package:http_client/console.dart';
import 'package:json_annotation/json_annotation.dart';

part 'oauth2_helper.g.dart';

class OAuth2Helper {
  final String shard;
  final String clientId;
  final String clientSecret;

  OAuth2Helper(this.shard, this.clientId, this.clientSecret);

  get redirectUrl => 'https://$shard.instructure.com/login/oauth2/auth?client_id=$clientId&response_type=code&redirect_uri=urn:ietf:wg:oauth:2.0:oob';
  get tokenUrl => 'https://$shard.instructure.com/login/oauth2/token?client_id=$clientId&response_type=code&client_secret=$clientSecret&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code';

  Future<TokenResults> getToken(String code) async {
    var client = new ConsoleClient();
    var response = await client.send(new Request('POST', '$tokenUrl&code=$code'));
    await client.close();
    var body = await response.readAsString();
    var jsonObject = json.decode(body);
    return new TokenResults.fromJson(jsonObject);
  }
}

@JsonSerializable()
class TokenResults extends Object with _$TokenResultsSerializerMixin {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  final User user;
  @JsonKey(name: 'expires_in')
  final int expiresIn;

  TokenResults(this.accessToken, this.tokenType, this.user, this.expiresIn);

  factory TokenResults.fromJson(Map<String, dynamic> json) => _$TokenResultsFromJson(json);
}

@JsonSerializable()
class User extends Object with _$UserSerializerMixin {
  final int id;
  final String name;

  User(this.id, this.name);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}