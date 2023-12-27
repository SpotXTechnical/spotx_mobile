import 'package:owner/generated/json/base/json_field.dart';
import 'package:owner/generated/json/guest.g.dart';

@JsonSerializable()
class Guest {
  factory Guest.fromJson(Map<String, dynamic> json) => $GuestFromJson(json);

  Map<String, dynamic> toJson() => $GuestToJson(this);

  int? id;
  String? name;
  String? phone;

  Guest({
    this.id,
    this.name,
    this.phone,
  });

  static Guest? createNewElement(Guest? oldElement) {
    if (oldElement != null) {
      return Guest(id: oldElement.id, name: oldElement.name, phone: oldElement.phone);
    }
    return null;
  }
}
