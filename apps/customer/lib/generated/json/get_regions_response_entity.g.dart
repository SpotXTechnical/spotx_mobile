import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';


GetRegionsResponseEntity $GetRegionsResponseEntityFromJson(Map<String, dynamic> json) {
	final GetRegionsResponseEntity getRegionsResponseEntity = GetRegionsResponseEntity();
	final List<Region>? data = jsonConvert.convertListNotNull<Region>(json['data']);
	if (data != null) {
		getRegionsResponseEntity.data = data;
	}
	return getRegionsResponseEntity;
}

Map<String, dynamic> $GetRegionsResponseEntityToJson(GetRegionsResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] =  entity.data?.map((v) => v.toJson()).toList();
	return data;
}

Region $RegionFromJson(Map<String, dynamic> json) {
	final Region region = Region();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		region.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		region.name = name;
	}
	final List<ImageEntity>? images = jsonConvert.convertListNotNull<ImageEntity>(json['images']);
	if (images != null) {
		region.images = images;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		region.description = description;
	}
	final List<Region>? subRegions = jsonConvert.convertListNotNull<Region>(json['sub_regions']);
	if (subRegions != null) {
		region.subRegions = subRegions;
	}
	final int? subRegionCount = jsonConvert.convert<int>(json['subRegion_count']);
	if (subRegionCount != null) {
		region.subRegionCount = subRegionCount;
	}
	final bool? hasSubRegion = jsonConvert.convert<bool>(json['has_subRegions']);
	if (hasSubRegion != null) {
		region.hasSubRegion = hasSubRegion;
	}
	return region;
}

Map<String, dynamic> $RegionToJson(Region entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['images'] =  entity.images?.map((v) => v.toJson()).toList();
	data['description'] = entity.description;
	data['sub_regions'] =  entity.subRegions?.map((v) => v.toJson()).toList();
	data['subRegion_count'] = entity.subRegionCount;
	data['has_subRegions'] = entity.hasSubRegion;
	return data;
}