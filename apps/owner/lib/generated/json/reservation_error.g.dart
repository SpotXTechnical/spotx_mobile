import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/reservation/model/reservation_error.dart';

ReservationError $ReservationErrorFromJson(Map<String, dynamic> json) {
  final ReservationError reservationError = ReservationError();
  final List<String>? unit = (json['unit'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (unit != null) {
    reservationError.unit = unit;
  }
  return reservationError;
}

Map<String, dynamic> $ReservationErrorToJson(ReservationError entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['unit'] = entity.unit;
  return data;
}

extension ReservationErrorExt on ReservationError {
  ReservationError copyWith({
    List<String>? unit,
  }) {
    return ReservationError()
      ..unit = unit ?? this.unit;
  }
}