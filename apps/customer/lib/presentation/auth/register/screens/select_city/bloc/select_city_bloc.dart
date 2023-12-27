import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/auth/i_auth_repository.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';
import 'package:spotx/presentation/auth/register/screens/select_city/bloc/select_city_event.dart';
import 'package:spotx/presentation/auth/register/screens/select_city/bloc/select_city_state.dart';
import 'package:spotx/utils/network/api_response.dart';

class SelectCityBloc extends BaseBloc<SelectCityEvent, SelectCityState> {
  SelectCityBloc(this.authRepository) : super(Cities(List.empty())) {
    on<GetCities>(_getCities);
  }

  final IAuthRepository authRepository;

  _getCities(GetCities event, Emitter<SelectCityState> emit) async {
    emit(const SelectCitiesLoading(true));
    ApiResponse apiResponse = await authRepository.getCities();
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<City> cities = apiResponse.data.data;
            emit((SelectCityState(cities: cities, isLoading: false)));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }
}
