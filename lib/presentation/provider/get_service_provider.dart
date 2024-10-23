import 'package:flutter/cupertino.dart';
import 'package:sims_ppob_nutech/domain/entities/service_response_entity.dart';
import 'package:sims_ppob_nutech/domain/usecase/get_services_usecase.dart';

class GetServiceProvider extends ChangeNotifier {
  GetServicesUsecase _getServicesUsecase;

  GetServiceProvider(this._getServicesUsecase);

  bool isLoading = false;
  bool isGetServicesSucceed = false;
  List<ServiceDataEntity>? _serviceData;
  String _message = "";

  String get message => _message;
  List<ServiceDataEntity>? get serviceData => _serviceData;

  Future<ServiceResponseEntity> getServices() async {
    isLoading = true;
    notifyListeners();
    final result = await _getServicesUsecase();

    if (result.data != null) {
      isGetServicesSucceed = true;
    }

    _serviceData = result.data;

    _message = result.message;
    isLoading = false;
    notifyListeners();

    return result;
  }
}