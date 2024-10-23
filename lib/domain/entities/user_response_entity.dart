import 'package:equatable/equatable.dart';

class UserResponseEntity extends Equatable {
  final int status;
  final String message;
  final UserDataEntity? data;

  UserResponseEntity({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List< Object ? > get props{
    return[
      status, message, data
    ];
  }
}

class UserDataEntity extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String profileImage;

  UserDataEntity({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  @override
  List<Object?> get props {
    return [
      email, firstName, lastName, profileImage
    ];
  }
}