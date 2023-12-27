import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/statistics/i_statistics_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/screens/add_payment/bloc/add_payment_event.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/style/theme.dart';

import 'add_payment_state.dart';

class AddPaymentBloc extends BaseBloc<AddPaymentEvent, AddPaymentState> {
  AddPaymentBloc(this.unitRepository, this.statisticsRepository) : super(const AddPaymentState()) {
    on<GetUnits>(_getUnits);
    on<SetUnitEvent>(_setUnit);
    on<AddDateEvent>(_addDate);
    on<HideError>(_hideError);
    on<AddPayment>(_addPayment);
    on<SetPayment>(_setPayment);
    on<UpdatePayment>(_updatePayment);
  }
  static final formKey = GlobalKey<FormState>();
  final FocusNode unitFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final IUnitRepository unitRepository;
  final IStatisticsRepository statisticsRepository;

  _setUnit(SetUnitEvent event, Emitter<AddPaymentState> emit) async {
    emit(state.copyWith(selectedUnit: event.selectedUnit));
    unitController.text = event.selectedUnit.title!;
  }

  _setPayment(SetPayment event, Emitter<AddPaymentState> emit) async {
    if (event.paymentEntity != null) {
      priceController.text = event.paymentEntity!.amount.toString();
      descriptionController.text = event.paymentEntity!.description.toString();
      dateController.text = DateFormat.yMd(event.localeCode).format(event.paymentEntity!.date!);
      emit(state.copyWith(
        date: dateController.text,
      ));
    }
  }

  _updatePayment(UpdatePayment event, Emitter<AddPaymentState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await statisticsRepository.updatePayment(event.paymentId, state.selectedUnit!.id!,
        dateController.text, priceController.text, descriptionController.text);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            emit(state.copyWith(isLoading: false));
            Fluttertoast.showToast(
                msg: LocaleKeys.updatePaymentSuccessMessage.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            navigationKey.currentState?.pop(true);
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _getUnits(GetUnits event, Emitter<AddPaymentState> emit) async {
    emit(state.copyWith(isUnitsLoading: true));
    ApiResponse apiResponse = await unitRepository.getUnits(FilterQueries());
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            if (units.isEmpty) {
              emit(state.copyWith(hasUnit: false));
            } else {
              Unit selectedUnit = units.first;
              if (event.unitId != null) {
                selectedUnit = units.firstWhere((element) => element.id == event.unitId);
              }
              emit(state.copyWith(units: units, isUnitsLoading: false, selectedUnit: selectedUnit));
              unitController.text = selectedUnit.title!;
            }
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _addDate(AddDateEvent event, Emitter<AddPaymentState> emit) async {
    dateController.text = event.date;
  }

  _hideError(HideError event, Emitter<AddPaymentState> emit) {
    emit(AddPaymentState(units: state.units, selectedUnit: state.selectedUnit));
  }

  _addPayment(AddPayment event, Emitter<AddPaymentState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await statisticsRepository.addPayment(
        state.selectedUnit!.id!, dateController.text, priceController.text, descriptionController.text);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            emit(state.copyWith(isLoading: false));
            Fluttertoast.showToast(
                msg: LocaleKeys.addPaymentSuccessMessage.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            navigationKey.currentState?.pop(true);
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }
}