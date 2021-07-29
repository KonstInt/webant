import 'dart:convert';

class TokenGet {
  String access_token;
  int expires_in;
  String token_type;
  String scope;
  String refresh_token;
  TokenGet({
    required this.access_token,
    required this.expires_in,
    required this.token_type,
    required this.scope,
    required this.refresh_token,
  });



  Map<String, dynamic> toMap() {
    return {
      'access_token': access_token,
      'expires_in': expires_in,
      'token_type': token_type,
      'scope': scope,
      'refresh_token': refresh_token,
    };
  }

  factory TokenGet.fromMap(Map<String, dynamic> map) {
    return TokenGet(
      access_token: map['access_token'],
      expires_in: map['expires_in'],
      token_type: map['token_type'],
      scope: map['scope'] != null ? map['scope'] :'',
      refresh_token: map['refresh_token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenGet.fromJson(String source) => TokenGet.fromMap(json.decode(source));
}
