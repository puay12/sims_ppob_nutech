import 'package:equatable/equatable.dart';

class LoginResponseEntity extends Equatable {
  final int status;
  final String message;
  final LoginDataEntity? data;

  LoginResponseEntity({
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

class LoginDataEntity extends Equatable {
  final String token;

  LoginDataEntity({
    required this.token,
  });

  @override
  List<Object?> get props {
    return [
      token
    ];
  }
}