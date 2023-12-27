import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/auth/models/guest.dart';

Guest $GuestFromJson(Map<String, dynamic> json) {
  final Guest guest = Guest();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    guest.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    guest.name = name;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    guest.phone = phone;
  }
  return guest;
}

Map<String, dynamic> $GuestToJson(Guest entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['phone'] = entity.phone;
  return data;
}

extension GuestExt on Guest {
  Guest copyWith({
    int? id,
    String? name,
    String? phone,
  }) {
    return Guest()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..phone = phone ?? this.phone;
  }
}