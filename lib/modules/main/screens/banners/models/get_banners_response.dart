import 'dart:convert';

GetBannerResponse getBannerResponseFromJson(dynamic json) =>
    GetBannerResponse.fromJson(json);

String getBannerResponseToJson(GetBannerResponse data) =>
    json.encode(data.toJson());

class GetBannerResponse {
  String result;
  List<BannersModel> data;
  int totalItems;
  GetBannerResponse({
    required this.result,
    required this.data,
    required this.totalItems,
  });

  GetBannerResponse copyWith({String? result, List<BannersModel>? data}) =>
      GetBannerResponse(
        result: result ?? this.result,
        data: data ?? this.data,
        totalItems: totalItems ?? this.totalItems,
      );

  factory GetBannerResponse.fromJson(Map<String, dynamic> json) =>
      GetBannerResponse(
        result: json["result"],
        totalItems: json["totalItems"],
        data: List<BannersModel>.from(
          json["data"].map((x) => BannersModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "totalItems": totalItems,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BannersModel {
  int id;
  String title;
  String subTitle;
  dynamic description;
  dynamic bannerLink;
  String image;
  String category;
  int displayOrder;
  bool status;
  String createdAt;
  String updatedAt;

  BannersModel({
    required this.id,
    required this.title,
    required this.category,
    required this.subTitle,
    required this.description,
    required this.bannerLink,
    required this.image,
    required this.displayOrder,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  BannersModel copyWith({
    int? id,
    String? title,
    String? subTitle,
    dynamic description,
    dynamic bannerLink,
    String? image,
    String? category,
    int? displayOrder,
    bool? status,
    String? createdAt,
    String? updatedAt,
  }) => BannersModel(
    id: id ?? this.id,
    title: title ?? this.title,
    subTitle: subTitle ?? this.subTitle,
    description: description ?? this.description,
    bannerLink: bannerLink ?? this.bannerLink,
    image: image ?? this.image,
    category: category ?? this.category,
    displayOrder: displayOrder ?? this.displayOrder,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory BannersModel.fromJson(Map<String, dynamic> json) => BannersModel(
    id: json["id"] ?? -1,
    title: json["title"] ?? "",
    subTitle: json["sub_title"] ?? "",
    description: json["description"] ?? "",
    bannerLink: json["banner_link"] ?? "",
    image: json["image"] ?? "",
    category: json["category"] ?? "",
    displayOrder: json["display_order"] ?? "",
    status: json["status"] ?? false,
    createdAt: json["createdAt"] ?? "",
    updatedAt: json["updatedAt"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sub_title": subTitle,
    "description": description,
    "banner_link": bannerLink,
    "image": image,
    "display_order": displayOrder,
    "status": status,
    "createdAt": createdAt,
    "category": category,
    "updatedAt": updatedAt,
  };
}
