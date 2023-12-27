import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

class CalenderUnit {
  final int id;
  final int defaultPrice;
  double? totalPrice;
  final String type;
  final String title;
  final List<ActiveRange>? activeRanges;
  final List<ActiveReservation>? activeReservations;
  final List<Room>? rooms;
  final Unit? unit;
  DateTime? startDate;
  DateTime? endDate;

  CalenderUnit(
      this.id, this.defaultPrice, this.type, this.activeRanges, this.activeReservations, this.rooms, this.title,
      {this.unit, this.startDate, this.endDate, this.totalPrice});
}
