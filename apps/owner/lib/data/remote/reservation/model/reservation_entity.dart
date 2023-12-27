import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/auth/models/guest.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/generated/json/base/json_field.dart';
import 'package:owner/generated/json/reservation_entity.g.dart';

@JsonSerializable()
class Reservation extends Equatable {
  factory Reservation.fromJson(Map<String, dynamic> json) =>
      $ReservationFromJson(json);

  Map<String, dynamic> toJson() => $ReservationToJson(this);

  int? id;
  DateTime? from;
  DateTime? to;
  @JSONField(name: "total_price")
  int? totalPrice;
  int? discount;
  @JSONField(name: "sub_total")
  int? subTotal;
  String? status;
  int? days;
  Unit? unit;
  User? customer;
  Guest? guest;
  bool? isAcceptEnabled = true;
  bool? isRejectEnabled = true;
  @JSONField(name: "has_cancel_request")
  bool? hasCancelRequest;

  Reservation({
    this.id,
    this.from,
    this.to,
    this.totalPrice,
    this.status,
    this.days,
    this.unit,
    this.isAcceptEnabled,
    this.isRejectEnabled,
    this.customer,
    this.guest,
    this.hasCancelRequest,
  });

  static List<Reservation> createNewReservationsList(List<Reservation>? reservations) {
    List<Reservation> newList = List.empty(growable: true);
    reservations?.forEach((element) {
      newList.add(
        Reservation()
          ..id = element.id
          ..from = element.from
          ..to = element.to
          ..totalPrice = element.totalPrice
          ..subTotal = element.subTotal
          ..discount = element.discount
          ..status = element.status
          ..days = element.days
          ..unit = element.unit
          ..isAcceptEnabled = element.isAcceptEnabled
          ..isRejectEnabled = element.isRejectEnabled
          ..customer = element.customer
          ..guest = element.guest
          ..hasCancelRequest = element.hasCancelRequest,
      );
    });
    return newList;
  }

  @override
  List<Object?> get props => [
        id,
        from,
        to,
        totalPrice,
        status,
        days,
        unit,
        isAcceptEnabled,
        isRejectEnabled,
        customer,
        guest,
        hasCancelRequest
      ];
}

enum ReservationStatus { approved, pending, reject }