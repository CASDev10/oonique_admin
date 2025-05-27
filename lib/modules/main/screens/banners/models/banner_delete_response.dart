import 'dart:convert';

BannerDeleteResponse bannerDeleteResponseFromJson(dynamic json) =>
    BannerDeleteResponse.fromJson(json);

String bannerDeleteResponseToJson(BannerDeleteResponse data) =>
    json.encode(data.toJson());

class BannerDeleteResponse {
  String result;
  String message;

  BannerDeleteResponse({required this.result, required this.message});

  BannerDeleteResponse copyWith({String? result, String? message}) =>
      BannerDeleteResponse(
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory BannerDeleteResponse.fromJson(Map<String, dynamic> json) =>
      BannerDeleteResponse(result: json["result"], message: json["message"]);

  Map<String, dynamic> toJson() => {"result": result, "message": message};
}
