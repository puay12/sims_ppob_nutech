import 'dart:convert';import 'package:sims_ppob_nutech/domain/entities/banner_response_entity.dart';

BannerResponseModel bannerResponseModelFromJson(String str) => BannerResponseModel.fromJson(json.decode(str));
String bannerResponseModelToJson(BannerResponseModel data) => json.encode(data.toJson());

class BannerResponseModel extends BannerResponseEntity {
  final int status;
  final String message;
  final List<BannerDataModel>? data;

  BannerResponseModel({
    required this.status,
    required this.message,
    required this.data,
  }) : super(status: status, message: message, data: data);

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) => BannerResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] != null ? List<BannerDataModel>.from(json["data"].map((x) => BannerDataModel.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
  };
}

class BannerDataModel extends BannerDataEntity {
  final String bannerName;
  final String bannerImage;
  final String description;

  BannerDataModel({
    required this.bannerName,
    required this.bannerImage,
    required this.description,
  }) : super(bannerName: bannerName, bannerImage: bannerImage, description: description);

  factory BannerDataModel.fromJson(Map<String, dynamic> json) => BannerDataModel(
    bannerName: json["banner_name"],
    bannerImage: json["banner_image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "banner_name": bannerName,
    "banner_image": bannerImage,
    "description": description,
  };
}