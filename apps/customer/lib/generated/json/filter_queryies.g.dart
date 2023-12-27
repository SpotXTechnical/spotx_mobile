import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';


FilterQueries $FilterQueriesFromJson(Map<String, dynamic> json) {
	final FilterQueries filterQueries = FilterQueries();
	final List<int>? minRooms = jsonConvert.convertListNotNull<int>(json['minRooms']);
	if (minRooms != null) {
		filterQueries.minRooms = minRooms;
	}
	final List<int>? minBeds = jsonConvert.convertListNotNull<int>(json['minBeds']);
	if (minBeds != null) {
		filterQueries.minBeds = minBeds;
	}
	final String? minGuest = jsonConvert.convert<String>(json['minGuest']);
	if (minGuest != null) {
		filterQueries.minGuest = minGuest;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		filterQueries.type = type;
	}
	final List<Region>? regions = jsonConvert.convertListNotNull<Region>(json['regions']);
	if (regions != null) {
		filterQueries.regions = regions;
	}
	final List<Region>? mainRegionsOfSubRegions = jsonConvert.convertListNotNull<Region>(json['mainRegionsOfSubRegions']);
	if (mainRegionsOfSubRegions != null) {
		filterQueries.mainRegionsOfSubRegions = mainRegionsOfSubRegions;
	}
	final String? minPrice = jsonConvert.convert<String>(json['minPrice']);
	if (minPrice != null) {
		filterQueries.minPrice = minPrice;
	}
	final String? maxPrice = jsonConvert.convert<String>(json['maxPrice']);
	if (maxPrice != null) {
		filterQueries.maxPrice = maxPrice;
	}
	final String? orderBy = jsonConvert.convert<String>(json['orderBy']);
	if (orderBy != null) {
		filterQueries.orderBy = orderBy;
	}
	final String? orderType = jsonConvert.convert<String>(json['orderType']);
	if (orderType != null) {
		filterQueries.orderType = orderType;
	}
	final int? perPage = jsonConvert.convert<int>(json['perPage']);
	if (perPage != null) {
		filterQueries.perPage = perPage;
	}
	final int? page = jsonConvert.convert<int>(json['page']);
	if (page != null) {
		filterQueries.page = page;
	}
	final String? sortType = jsonConvert.convert<String>(json['sortType']);
	if (sortType != null) {
		filterQueries.sortType = sortType;
	}
	final int? mostPoplar = jsonConvert.convert<int>(json['mostPoplar']);
	if (mostPoplar != null) {
		filterQueries.mostPoplar = mostPoplar;
	}
	final String? ownerId = jsonConvert.convert<String>(json['ownerId']);
	if (ownerId != null) {
		filterQueries.ownerId = ownerId;
	}
	final bool? isComingFromSearchScreenWithSubRegions = jsonConvert.convert<bool>(json['isComingFromSearchScreenWithSubRegions']);
	if (isComingFromSearchScreenWithSubRegions != null) {
		filterQueries.isComingFromSearchScreenWithSubRegions = isComingFromSearchScreenWithSubRegions;
	}
	return filterQueries;
}

Map<String, dynamic> $FilterQueriesToJson(FilterQueries entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['minRooms'] =  entity.minRooms;
	data['minBeds'] =  entity.minBeds;
	data['minGuest'] = entity.minGuest;
	data['type'] = entity.type;
	data['regions'] =  entity.regions.map((v) => v.toJson()).toList();
	data['mainRegionsOfSubRegions'] =  entity.mainRegionsOfSubRegions.map((v) => v.toJson()).toList();
	data['minPrice'] = entity.minPrice;
	data['maxPrice'] = entity.maxPrice;
	data['orderBy'] = entity.orderBy;
	data['orderType'] = entity.orderType;
	data['perPage'] = entity.perPage;
	data['page'] = entity.page;
	data['sortType'] = entity.sortType;
	data['mostPoplar'] = entity.mostPoplar;
	data['ownerId'] = entity.ownerId;
	data['isComingFromSearchScreenWithSubRegions'] = entity.isComingFromSearchScreenWithSubRegions;
	return data;
}