import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';

ImageEntity $ImageEntityFromJson(Map<String, dynamic> json) {
	final ImageEntity imageEntity = ImageEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		imageEntity.id = id;
	}
	final int? unitId = jsonConvert.convert<int>(json['unit_id']);
	if (unitId != null) {
		imageEntity.unitId = unitId;
	}
	final dynamic model = jsonConvert.convert<dynamic>(json['model']);
	if (model != null) {
		imageEntity.model = model;
	}
	final String? path = jsonConvert.convert<String>(json['path']);
	if (path != null) {
		imageEntity.path = path;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		imageEntity.type = type;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		imageEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		imageEntity.updatedAt = updatedAt;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		imageEntity.url = url;
	}
	final String? thumbnail = jsonConvert.convert<String>(json['thumbnail']);
	if (thumbnail != null) {
		imageEntity.thumbnail = thumbnail;
	}
	final int? isDefault = jsonConvert.convert<int>(json['is_default']);
	if (isDefault != null) {
		imageEntity.isDefault = isDefault;
	}
	return imageEntity;
}

Map<String, dynamic> $ImageEntityToJson(ImageEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['unit_id'] = entity.unitId;
	data['model'] = entity.model;
	data['path'] = entity.path;
	data['type'] = entity.type;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['url'] = entity.url;
	data['thumbnail'] = entity.thumbnail;
	data['is_default'] = entity.isDefault;
	return data;
}