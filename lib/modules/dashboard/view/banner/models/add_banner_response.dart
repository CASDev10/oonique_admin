import 'dart:convert';

AddBannerResponse addBannerResponseFromJson(dynamic json) =>
    AddBannerResponse.fromJson(json);

String addBannerResponseToJson(AddBannerResponse data) =>
    json.encode(data.toJson());

class AddBannerResponse {
  String result;
  // Data data;

  AddBannerResponse({required this.result, 
  // required this.data
  
  });

  AddBannerResponse copyWith({String? result, Data? data}) =>
      AddBannerResponse(result: result ?? this.result, 
      
      
      // data: data ?? this.data
      
      
      );

  factory AddBannerResponse.fromJson(Map<String, dynamic> json) =>
      AddBannerResponse(
        result: json["result"],
        // data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"result": result, 
  
  
  
  // "data": data.toJson()
  
  };
}

class Data {
  int id;
  String title;
  String subTitle;
  String description;
  String bannerLink;
  String displayOrder;
  bool status;
  String image;

  Data({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.bannerLink,
    required this.displayOrder,
    required this.status,
    required this.image,
  });

  Data copyWith({
    int? id,
    String? title,
    String? subTitle,
    String? description,
    String? bannerLink,
    String? displayOrder,
    bool? status,
    String? image,
  }) => Data(
    id: id ?? this.id,
    title: title ?? this.title,
    subTitle: subTitle ?? this.subTitle,
    description: description ?? this.description,
    bannerLink: bannerLink ?? this.bannerLink,
    displayOrder: displayOrder ?? this.displayOrder,
    status: status ?? this.status,
    image: image ?? this.image,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? -1,
    title: json["title"] ?? "",
    subTitle: json["sub_title"] ?? "",
    description: json["description"] ?? "",
    bannerLink: json["banner_link"] ?? "",
    displayOrder: json["display_order"] ?? "",
    status: json["status"] ?? false,
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sub_title": subTitle,
    "description": description,
    "banner_link": bannerLink,
    "display_order": displayOrder,
    "status": status,
    "image": image,
  };
}
