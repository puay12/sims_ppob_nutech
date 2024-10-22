import 'package:equatable/equatable.dart';

class RegistResponseEntity extends Equatable {
  final int status;
  final String message;
  final dynamic data;

  RegistResponseEntity({
    required this.status,
    required this.message,
    this.data,
  });

  @override
  List< Object ? > get props{
    return[
      status, message, data
    ];
  }
}