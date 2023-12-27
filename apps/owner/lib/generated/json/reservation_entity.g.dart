import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';

import 'package:owner/data/remote/add_unit/model/unit.dart';

import 'package:owner/data/remote/auth/models/guest.dart';

import 'package:owner/data/remote/auth/models/login_response_entity.dart';


Reservation $ReservationFromJson(Map<String, dynamic> json) {
  final Reservation reservation = Reservation();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    reservation.id = id;
  }
  final DateTime? from = jsonConvert.convert<DateTime>(json['from']);
  if (from != null) {
    reservation.from = from;
  }
  final DateTime? to = jsonConvert.convert<DateTime>(json['to']);
  if (to != null) {
    reservation.to = to;
  }
  final int? totalPrice = jsonConvert.convert<int>(json['total_price']);
  if (totalPrice != null) {
    reservation.totalPrice = totalPrice;
  }
  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    reservation.discount = discount;
  }
  final int? subTotal = jsonConvert.convert<int>(json['sub_total']);
  if (subTotal != null) {
    reservation.subTotal = subTotal;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    reservation.status = status;
  }
  final int? days = jsonConvert.convert<int>(json['days']);
  if (days != null) {
    reservation.days = days;
  }
  final Unit? unit = jsonConvert.convert<Unit>(json['unit']);
  if (unit != null) {
    reservation.unit = unit;
  }
  final User? customer = jsonConvert.convert<User>(json['customer']);
  if (customer != null) {
    reservation.customer = customer;
  }
  final Guest? guest = jsonConvert.convert<Guest>(json['guest']);
  if (guest != null) {
    reservation.guest = guest;
  }
  final bool? isAcceptEnabled = jsonConvert.convert<bool>(
      json['isAcceptEnabled']);
  if (isAcceptEnabled != null) {
    reservation.isAcceptEnabled = isAcceptEnabled;
  }
  final bool? isRejectEnabled = jsonConvert.convert<bool>(
      json['isRejectEnabled']);
  if (isRejectEnabled != null) {
    reservation.isRejectEnabled = isRejectEnabled;
  }
  final bool? hasCancelRequest = jsonConvert.convert<bool>(
      json['has_cancel_request']);
  if (hasCancelRequest != null) {
    reservation.hasCancelRequest = hasCancelRequest;
  }
  return reservation;
}

Map<String, dynamic> $ReservationToJson(Reservation entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['from'] = entity.from?.toIso8601String();
  data['to'] = entity.to?.toIso8601String();
  data['total_price'] = entity.totalPrice;
  data['discount'] = entity.discount;
  data['sub_total'] = entity.subTotal;
  data['status'] = entity.status;
  data['days'] = entity.days;
  data['unit'] = entity.unit?.toJson();
  data['customer'] = entity.customer?.toJson();
  data['guest'] = entity.guest?.toJson();
  data['isAcceptEnabled'] = entity.isAcceptEnabled;
  data['isRejectEnabled'] = entity.isRejectEnabled;
  data['has_cancel_request'] = entity.hasCancelRequest;
  return data;
}

extension ReservationExt on Reservation {
  Reservation copyWith({
    int? id,
    DateTime? from,
    DateTime? to,
    int? totalPrice,
    int? discount,
    int? subTotal,
    String? status,
    int? days,
    Unit? unit,
    User? customer,
    Guest? guest,
    bool? isAcceptEnabled,
    bool? isRejectEnabled,
    bool? hasCancelRequest,
  }) {
    return Reservation()
      ..id = id ?? this.id
      ..from = from ?? this.from
      ..to = to ?? this.to
      ..totalPrice = totalPrice ?? this.totalPrice
      ..discount = discount ?? this.discount
      ..subTotal = subTotal ?? this.subTotal
      ..status = status ?? this.status
      ..days = days ?? this.days
      ..unit = unit ?? this.unit
      ..customer = customer ?? this.customer
      ..guest = guest ?? this.guest
      ..isAcceptEnabled = isAcceptEnabled ?? this.isAcceptEnabled
      ..isRejectEnabled = isRejectEnabled ?? this.isRejectEnabled
      ..hasCancelRequest = hasCancelRequest ?? this.hasCancelRequest;
  }
}