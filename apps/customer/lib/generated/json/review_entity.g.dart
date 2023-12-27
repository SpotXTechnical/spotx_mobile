import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/unit/model/review_entity.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';


ReviewEntity $ReviewEntityFromJson(Map<String, dynamic> json) {
	final ReviewEntity reviewEntity = ReviewEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		reviewEntity.id = id;
	}
	final int? reservationId = jsonConvert.convert<int>(json['reservation_id']);
	if (reservationId != null) {
		reviewEntity.reservationId = reservationId;
	}
	final int? unitId = jsonConvert.convert<int>(json['unit_id']);
	if (unitId != null) {
		reviewEntity.unitId = unitId;
	}
	final int? userId = jsonConvert.convert<int>(json['user_id']);
	if (userId != null) {
		reviewEntity.userId = userId;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		reviewEntity.message = message;
	}
	final int? unitRate = jsonConvert.convert<int>(json['unit_rate']);
	if (unitRate != null) {
		reviewEntity.unitRate = unitRate;
	}
	final int? ownerRate = jsonConvert.convert<int>(json['owner_rate']);
	if (ownerRate != null) {
		reviewEntity.ownerRate = ownerRate;
	}
	final DateTime? createdAt = jsonConvert.convert<DateTime>(json['created_at']);
	if (createdAt != null) {
		reviewEntity.createdAt = createdAt;
	}
	final DateTime? updatedAt = jsonConvert.convert<DateTime>(json['updated_at']);
	if (updatedAt != null) {
		reviewEntity.updatedAt = updatedAt;
	}
	final User? user = jsonConvert.convert<User>(json['user']);
	if (user != null) {
		reviewEntity.user = user;
	}
	return reviewEntity;
}

Map<String, dynamic> $ReviewEntityToJson(ReviewEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['reservation_id'] = entity.reservationId;
	data['unit_id'] = entity.unitId;
	data['user_id'] = entity.userId;
	data['message'] = entity.message;
	data['unit_rate'] = entity.unitRate;
	data['owner_rate'] = entity.ownerRate;
	data['created_at'] = entity.createdAt?.toIso8601String();
	data['updated_at'] = entity.updatedAt?.toIso8601String();
	data['user'] = entity.user?.toJson();
	return data;
}