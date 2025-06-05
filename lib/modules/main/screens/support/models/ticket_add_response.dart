import 'dart:convert';

TicketAddResponse ticketAddResponseFromJson(dynamic json) =>
    TicketAddResponse.fromJson(json);

String ticketAddResponseToJson(TicketAddResponse data) =>
    json.encode(data.toJson());

class TicketAddResponse {
  String result;
  List<Datum> data;

  TicketAddResponse({required this.result, required this.data});

  TicketAddResponse copyWith({String? result, List<Datum>? data}) =>
      TicketAddResponse(result: result ?? this.result, data: data ?? this.data);

  factory TicketAddResponse.fromJson(Map<String, dynamic> json) =>
      TicketAddResponse(
        result: json["result"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int supportId;
  String message;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> images;

  Datum({
    required this.id,
    required this.supportId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  Datum copyWith({
    int? id,
    int? supportId,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic>? images,
  }) => Datum(
    id: id ?? this.id,
    supportId: supportId ?? this.supportId,
    message: message ?? this.message,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    images: images ?? this.images,
  );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    supportId: json["support_id"],
    message: json["message"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    images: List<dynamic>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "support_id": supportId,
    "message": message,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}
