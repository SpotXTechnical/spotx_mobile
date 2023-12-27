import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/statistics/model/payment_entity.dart';

abstract class AddPaymentEvent extends Equatable {
  const AddPaymentEvent();
}

class GetHomeCampsEvent extends AddPaymentEvent {
  const GetHomeCampsEvent();

  @override
  List<Object?> get props => [];
}

class GetUnits extends AddPaymentEvent {
  final String? unitId;
  const GetUnits(this.unitId);

  @override
  List<Object?> get props => [unitId];
}

class SetUnitEvent extends AddPaymentEvent {
  final Unit selectedUnit;
  const SetUnitEvent(this.selectedUnit);

  @override
  List<Object?> get props => [selectedUnit];
}

class AddDateEvent extends AddPaymentEvent {
  final String date;
  const AddDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class HideError extends AddPaymentEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class AddPayment extends AddPaymentEvent {
  const AddPayment();
  @override
  List<Object?> get props => [];
}

class SetPayment extends AddPaymentEvent {
  final PaymentEntity? paymentEntity;
  final String? localeCode;
  const SetPayment(this.paymentEntity, this.localeCode);
  @override
  List<Object?> get props => [paymentEntity, localeCode];
}

class UpdatePayment extends AddPaymentEvent {
  final String paymentId;
  const UpdatePayment(this.paymentId);
  @override
  List<Object?> get props => [paymentId];
}
