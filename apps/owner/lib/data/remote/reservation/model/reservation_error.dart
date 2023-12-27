import 'package:owner/generated/json/base/json_field.dart';
import 'package:owner/generated/json/reservation_error.g.dart';

@JsonSerializable()
class ReservationError {
  ReservationError();

  factory ReservationError.fromJson(Map<String, dynamic> json) => $ReservationErrorFromJson(json);

  Map<String, dynamic> toJson() => $ReservationErrorToJson(this);

  List<String>? unit;
}
