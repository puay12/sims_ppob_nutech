import 'package:equatable/equatable.dart';

class BannerResponseEntity extends Equatable {
  final int status;
  final String message;
  final List<BannerDataEntity>? data;

  BannerResponseEntity({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props {
    return [
      status, message, data
    ];
  }

}

class BannerDataEntity extends Equatable {
  final String bannerName;
  final String bannerImage;
  final String description;

  BannerDataEntity({
    required this.bannerName,
    required this.bannerImage,
    required this.description,
  });

  @override
  List<Object?> get props {
    return [
      bannerName, bannerImage, description
    ];
  }
}