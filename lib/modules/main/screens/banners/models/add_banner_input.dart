import 'package:dio/dio.dart';

class AddBannerInput {
  int? id;
  String title;
  String subTitle;
  String description;
  String bannerLink;
  String displayOrder;
  String status;
  MultipartFile? file;
  AddBannerInput({
    required this.title,
    required this.subTitle,
    required this.description,
    required this.bannerLink,
    required this.displayOrder,
    required this.status,
    this.file,
    this.id,
  });

  AddBannerInput copyWith({
    String? title,
    String? subTitle,
    String? description,
    String? bannerLink,
    String? displayOrder,
    String? status,
    int? id,
    MultipartFile? file,
  }) => AddBannerInput(
    title: title ?? this.title,
    file: file ?? this.file,
    subTitle: subTitle ?? this.subTitle,
    description: description ?? this.description,
    bannerLink: bannerLink ?? this.bannerLink,
    displayOrder: displayOrder ?? this.displayOrder,
    status: status ?? this.status,
    id: id ?? this.id,
  );

  factory AddBannerInput.fromJson(Map<String, dynamic> json) => AddBannerInput(
    title: json["title"],
    subTitle: json["sub_title"],
    description: json["description"],
    bannerLink: json["banner_link"],
    displayOrder: json["display_order"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "sub_title": subTitle,
    "description": description,
    "banner_link": bannerLink,
    "display_order": displayOrder,
    "status": status,
  };
}
