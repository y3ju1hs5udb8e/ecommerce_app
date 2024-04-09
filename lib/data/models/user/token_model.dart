class TokenModel {
  final String accessToken;
  final String refreshToken;

  TokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  //fromJson
  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String,
      );

  //empty
  factory TokenModel.empty() => TokenModel(
        accessToken: 'invalid',
        refreshToken: 'invalid',
      );

  //to amp
  Map<String, dynamic> toJson() => <String, dynamic>{
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
