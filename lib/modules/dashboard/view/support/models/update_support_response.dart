import 'dart:convert';

UpdateSupportResponse updateSupportResponseFromJson(dynamic json) =>
    UpdateSupportResponse.fromJson(json);

String updateSupportResponseToJson(UpdateSupportResponse data) =>
    json.encode(data.toJson());

class UpdateSupportResponse {
  String result;
  String message;

  UpdateSupportResponse({required this.result, required this.message});

  UpdateSupportResponse copyWith({String? result, String? message}) =>
      UpdateSupportResponse(
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory UpdateSupportResponse.fromJson(Map<String, dynamic> json) =>
      UpdateSupportResponse(result: json["result"], message: json["message"]);

  Map<String, dynamic> toJson() => {"result": result, "message": message};
}
