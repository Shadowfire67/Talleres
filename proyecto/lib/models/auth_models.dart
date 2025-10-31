class AuthTokens {
  final String accessToken;
  final String? refreshToken;
  AuthTokens({required this.accessToken, this.refreshToken});
}

class AuthUser {
  final String? name;
  final String? email;
  AuthUser({this.name, this.email});
}

class AuthResult {
  final AuthTokens tokens;
  final AuthUser user;
  AuthResult({required this.tokens, required this.user});
}
