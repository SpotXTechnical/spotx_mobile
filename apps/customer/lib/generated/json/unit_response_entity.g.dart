import 'package:spotx/generated/json/base/json_convert_content.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';

import 'package:spotx/data/remote/unit/model/review_entity.dart';

import 'package:spotx/utils/network/list_helper/links.dart';

import 'package:spotx/utils/network/list_helper/meta.dart';


UnitResponseEntity $UnitResponseEntityFromJson(Map<String, dynamic> json) {
	final UnitResponseEntity unitResponseEntity = UnitResponseEntity();
	final List<Unit>? data = jsonConvert.convertListNotNull<Unit>(json['data']);
	if (data != null) {
		unitResponseEntity.data = data;
	}
	final Links? links = jsonConvert.convert<Links>(json['links']);
	if (links != null) {
		unitResponseEntity.links = links;
	}
	final Meta? meta = jsonConvert.convert<Meta>(json['meta']);
	if (meta != null) {
		unitResponseEntity.meta = meta;
	}
	return unitResponseEntity;
}

Map<String, dynamic> $UnitResponseEntityToJson(UnitResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] =  entity.data?.map((v) => v.toJson()).toList();
	data['links'] = entity.links?.toJson();
	data['meta'] = entity.meta?.toJson();
	return data;
}

Unit $UnitFromJson(Map<String, dynamic> json) {
	final Unit unit = Unit();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		unit.id = id;
	}
	final String? code = jsonConvert.convert<String>(json['code']);
	if (code != null) {
		unit.code = code;
	}
	final int? defaultPrice = jsonConvert.convert<int>(json['default_price']);
	if (defaultPrice != null) {
		unit.defaultPrice = defaultPrice;
	}
	final int? currentPrice = jsonConvert.convert<int>(json['current_price']);
	if (currentPrice != null) {
		unit.currentPrice = currentPrice;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		unit.title = title;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		unit.description = description;
	}
	final String? longitude = jsonConvert.convert<String>(json['longitude']);
	if (longitude != null) {
		unit.longitude = longitude;
	}
	final String? latitude = jsonConvert.convert<String>(json['latitude']);
	if (latitude != null) {
		unit.latitude = latitude;
	}
	final String? checkIn = jsonConvert.convert<String>(json['check_in']);
	if (checkIn != null) {
		unit.checkIn = checkIn;
	}
	final String? checkOut = jsonConvert.convert<String>(json['check_out']);
	if (checkOut != null) {
		unit.checkOut = checkOut;
	}
	final int? bedRooms = jsonConvert.convert<int>(json['bed_rooms']);
	if (bedRooms != null) {
		unit.bedRooms = bedRooms;
	}
	final int? beds = jsonConvert.convert<int>(json['beds']);
	if (beds != null) {
		unit.beds = beds;
	}
	final int? guests = jsonConvert.convert<int>(json['guests']);
	if (guests != null) {
		unit.guests = guests;
	}
	final int? bathrooms = jsonConvert.convert<int>(json['bathrooms']);
	if (bathrooms != null) {
		unit.bathrooms = bathrooms;
	}
	final int? regionId = jsonConvert.convert<int>(json['region_id']);
	if (regionId != null) {
		unit.regionId = regionId;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		unit.address = address;
	}
	final int? isVisible = jsonConvert.convert<int>(json['is_visible']);
	if (isVisible != null) {
		unit.isVisible = isVisible;
	}
	final dynamic reservationsCount = jsonConvert.convert<dynamic>(json['reservations_count']);
	if (reservationsCount != null) {
		unit.reservationsCount = reservationsCount;
	}
	final dynamic nearLowerPrice = jsonConvert.convert<dynamic>(json['near_lower_price']);
	if (nearLowerPrice != null) {
		unit.nearLowerPrice = nearLowerPrice;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		unit.type = type;
	}
	final int? isFamiliesOnly = jsonConvert.convert<int>(json['is_families_only']);
	if (isFamiliesOnly != null) {
		unit.isFamiliesOnly = isFamiliesOnly;
	}
	final List<ActiveRange>? activeRanges = jsonConvert.convertListNotNull<ActiveRange>(json['active_ranges']);
	if (activeRanges != null) {
		unit.activeRanges = activeRanges;
	}
	final List<ActiveReservation>? activeReservations = jsonConvert.convertListNotNull<ActiveReservation>(json['active_reservations']);
	if (activeReservations != null) {
		unit.activeReservations = activeReservations;
	}
	final List<ImageEntity>? images = jsonConvert.convertListNotNull<ImageEntity>(json['images']);
	if (images != null) {
		unit.images = images;
	}
	final List<ReviewEntity>? reviews = jsonConvert.convertListNotNull<ReviewEntity>(json['reviews']);
	if (reviews != null) {
		unit.reviews = reviews;
	}
	final Owner? owner = jsonConvert.convert<Owner>(json['owner']);
	if (owner != null) {
		unit.owner = owner;
	}
	final bool? isFavourite = jsonConvert.convert<bool>(json['is_favourite']);
	if (isFavourite != null) {
		unit.isFavourite = isFavourite;
	}
	final bool? uiIsFavourite = jsonConvert.convert<bool>(json['is_favourite']);
	if (uiIsFavourite != null) {
		unit.uiIsFavourite = uiIsFavourite;
	}
	final bool? isFavouriteLoading = jsonConvert.convert<bool>(json['isFavouriteLoading']);
	if (isFavouriteLoading != null) {
		unit.isFavouriteLoading = isFavouriteLoading;
	}
	final List<Room>? rooms = jsonConvert.convertListNotNull<Room>(json['rooms']);
	if (rooms != null) {
		unit.rooms = rooms;
	}
	final double? rate = jsonConvert.convert<double>(json['avg_unit_rate']);
	if (rate != null) {
		unit.rate = rate;
	}
	final List<Feature>? features = jsonConvert.convertListNotNull<Feature>(json['features']);
	if (features != null) {
		unit.features = features;
	}
	final ImageEntity? mainImage = jsonConvert.convert<ImageEntity>(json['main_image']);
	if (mainImage != null) {
		unit.mainImage = mainImage;
	}
	final String? regionName = jsonConvert.convert<String>(json['region_name']);
	if (regionName != null) {
		unit.regionName = regionName;
	}
	final String? subRegionName = jsonConvert.convert<String>(json['sub_region_name']);
	if (subRegionName != null) {
		unit.subRegionName = subRegionName;
	}
	final int? discountPercentage = jsonConvert.convert<int>(json['discount_percentage']);
	if (discountPercentage != null) {
		unit.discountPercentage = discountPercentage;
	}
	return unit;
}

Map<String, dynamic> $UnitToJson(Unit entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['code'] = entity.code;
	data['default_price'] = entity.defaultPrice;
	data['current_price'] = entity.currentPrice;
	data['title'] = entity.title;
	data['description'] = entity.description;
	data['longitude'] = entity.longitude;
	data['latitude'] = entity.latitude;
	data['check_in'] = entity.checkIn;
	data['check_out'] = entity.checkOut;
	data['bed_rooms'] = entity.bedRooms;
	data['beds'] = entity.beds;
	data['guests'] = entity.guests;
	data['bathrooms'] = entity.bathrooms;
	data['region_id'] = entity.regionId;
	data['address'] = entity.address;
	data['is_visible'] = entity.isVisible;
	data['reservations_count'] = entity.reservationsCount;
	data['near_lower_price'] = entity.nearLowerPrice;
	data['type'] = entity.type;
	data['is_families_only'] = entity.isFamiliesOnly;
	data['active_ranges'] =  entity.activeRanges?.map((v) => v.toJson()).toList();
	data['active_reservations'] =  entity.activeReservations?.map((v) => v.toJson()).toList();
	data['images'] =  entity.images?.map((v) => v.toJson()).toList();
	data['reviews'] =  entity.reviews?.map((v) => v.toJson()).toList();
	data['owner'] = entity.owner?.toJson();
	data['is_favourite'] = entity.isFavourite;
	data['is_favourite'] = entity.uiIsFavourite;
	data['isFavouriteLoading'] = entity.isFavouriteLoading;
	data['rooms'] =  entity.rooms?.map((v) => v.toJson()).toList();
	data['avg_unit_rate'] = entity.rate;
	data['features'] =  entity.features?.map((v) => v.toJson()).toList();
	data['main_image'] = entity.mainImage?.toJson();
	data['region_name'] = entity.regionName;
	data['sub_region_name'] = entity.subRegionName;
	data['discount_percentage'] = entity.discountPercentage;
	return data;
}

GetUnitResponseDataRegion $GetUnitResponseDataRegionFromJson(Map<String, dynamic> json) {
	final GetUnitResponseDataRegion getUnitResponseDataRegion = GetUnitResponseDataRegion();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		getUnitResponseDataRegion.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		getUnitResponseDataRegion.name = name;
	}
	final dynamic description = jsonConvert.convert<dynamic>(json['description']);
	if (description != null) {
		getUnitResponseDataRegion.description = description;
	}
	return getUnitResponseDataRegion;
}

Map<String, dynamic> $GetUnitResponseDataRegionToJson(GetUnitResponseDataRegion entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['description'] = entity.description;
	return data;
}

GetUnitResponseMetaLinks $GetUnitResponseMetaLinksFromJson(Map<String, dynamic> json) {
	final GetUnitResponseMetaLinks getUnitResponseMetaLinks = GetUnitResponseMetaLinks();
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		getUnitResponseMetaLinks.url = url;
	}
	final String? label = jsonConvert.convert<String>(json['label']);
	if (label != null) {
		getUnitResponseMetaLinks.label = label;
	}
	final bool? active = jsonConvert.convert<bool>(json['active']);
	if (active != null) {
		getUnitResponseMetaLinks.active = active;
	}
	return getUnitResponseMetaLinks;
}

Map<String, dynamic> $GetUnitResponseMetaLinksToJson(GetUnitResponseMetaLinks entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['url'] = entity.url;
	data['label'] = entity.label;
	data['active'] = entity.active;
	return data;
}

ActiveRange $ActiveRangeFromJson(Map<String, dynamic> json) {
	final ActiveRange activeRange = ActiveRange();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		activeRange.id = id;
	}
	final String? rangableType = jsonConvert.convert<String>(json['rangable_type']);
	if (rangableType != null) {
		activeRange.rangableType = rangableType;
	}
	final int? rangableId = jsonConvert.convert<int>(json['rangable_id']);
	if (rangableId != null) {
		activeRange.rangableId = rangableId;
	}
	final String? from = jsonConvert.convert<String>(json['from']);
	if (from != null) {
		activeRange.from = from;
	}
	final String? to = jsonConvert.convert<String>(json['to']);
	if (to != null) {
		activeRange.to = to;
	}
	final int? price = jsonConvert.convert<int>(json['price']);
	if (price != null) {
		activeRange.price = price;
	}
	final bool? isOffer = jsonConvert.convert<bool>(json['is_offer']);
	if (isOffer != null) {
		activeRange.isOffer = isOffer;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		activeRange.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		activeRange.updatedAt = updatedAt;
	}
	final DateTime? startDay = jsonConvert.convert<DateTime>(json['from']);
	if (startDay != null) {
		activeRange.startDay = startDay;
	}
	final DateTime? endDay = jsonConvert.convert<DateTime>(json['to']);
	if (endDay != null) {
		activeRange.endDay = endDay;
	}
	final bool? isComingFromOfferScreen = jsonConvert.convert<bool>(json['isComingFromOfferScreen']);
	if (isComingFromOfferScreen != null) {
		activeRange.isComingFromOfferScreen = isComingFromOfferScreen;
	}
	return activeRange;
}

Map<String, dynamic> $ActiveRangeToJson(ActiveRange entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['rangable_type'] = entity.rangableType;
	data['rangable_id'] = entity.rangableId;
	data['from'] = entity.from;
	data['to'] = entity.to;
	data['price'] = entity.price;
	data['is_offer'] = entity.isOffer;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['from'] = entity.startDay?.toIso8601String();
	data['to'] = entity.endDay?.toIso8601String();
	data['isComingFromOfferScreen'] = entity.isComingFromOfferScreen;
	return data;
}

ActiveReservation $ActiveReservationFromJson(Map<String, dynamic> json) {
	final ActiveReservation activeReservation = ActiveReservation();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		activeReservation.id = id;
	}
	final String? from = jsonConvert.convert<String>(json['from']);
	if (from != null) {
		activeReservation.from = from;
	}
	final String? to = jsonConvert.convert<String>(json['to']);
	if (to != null) {
		activeReservation.to = to;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		activeReservation.status = status;
	}
	final String? reservableType = jsonConvert.convert<String>(json['reservable_type']);
	if (reservableType != null) {
		activeReservation.reservableType = reservableType;
	}
	final int? reservableId = jsonConvert.convert<int>(json['reservable_id']);
	if (reservableId != null) {
		activeReservation.reservableId = reservableId;
	}
	final String? userableType = jsonConvert.convert<String>(json['userable_type']);
	if (userableType != null) {
		activeReservation.userableType = userableType;
	}
	final int? userableId = jsonConvert.convert<int>(json['userable_id']);
	if (userableId != null) {
		activeReservation.userableId = userableId;
	}
	final int? totalPrice = jsonConvert.convert<int>(json['total_price']);
	if (totalPrice != null) {
		activeReservation.totalPrice = totalPrice;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		activeReservation.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		activeReservation.updatedAt = updatedAt;
	}
	final DateTime? startDay = jsonConvert.convert<DateTime>(json['from']);
	if (startDay != null) {
		activeReservation.startDay = startDay;
	}
	final DateTime? endDay = jsonConvert.convert<DateTime>(json['to']);
	if (endDay != null) {
		activeReservation.endDay = endDay;
	}
	return activeReservation;
}

Map<String, dynamic> $ActiveReservationToJson(ActiveReservation entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['from'] = entity.from;
	data['to'] = entity.to;
	data['status'] = entity.status;
	data['reservable_type'] = entity.reservableType;
	data['reservable_id'] = entity.reservableId;
	data['userable_type'] = entity.userableType;
	data['userable_id'] = entity.userableId;
	data['total_price'] = entity.totalPrice;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['from'] = entity.startDay?.toIso8601String();
	data['to'] = entity.endDay?.toIso8601String();
	return data;
}

Owner $OwnerFromJson(Map<String, dynamic> json) {
	final Owner owner = Owner();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		owner.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		owner.name = name;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		owner.email = email;
	}
	final dynamic emailVerifiedAt = jsonConvert.convert<dynamic>(json['email_verified_at']);
	if (emailVerifiedAt != null) {
		owner.emailVerifiedAt = emailVerifiedAt;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		owner.phone = phone;
	}
	final dynamic phoneVerifiedAt = jsonConvert.convert<dynamic>(json['phone_verified_at']);
	if (phoneVerifiedAt != null) {
		owner.phoneVerifiedAt = phoneVerifiedAt;
	}
	final dynamic image = jsonConvert.convert<dynamic>(json['image']);
	if (image != null) {
		owner.image = image;
	}
	final dynamic nationalIdImage = jsonConvert.convert<dynamic>(json['national_id_image']);
	if (nationalIdImage != null) {
		owner.nationalIdImage = nationalIdImage;
	}
	final String? nationalId = jsonConvert.convert<String>(json['national_id']);
	if (nationalId != null) {
		owner.nationalId = nationalId;
	}
	final String? whatsapp = jsonConvert.convert<String>(json['whatsapp']);
	if (whatsapp != null) {
		owner.whatsapp = whatsapp;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		owner.type = type;
	}
	return owner;
}

Map<String, dynamic> $OwnerToJson(Owner entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['email'] = entity.email;
	data['email_verified_at'] = entity.emailVerifiedAt;
	data['phone'] = entity.phone;
	data['phone_verified_at'] = entity.phoneVerifiedAt;
	data['image'] = entity.image;
	data['national_id_image'] = entity.nationalIdImage;
	data['national_id'] = entity.nationalId;
	data['whatsapp'] = entity.whatsapp;
	data['type'] = entity.type;
	return data;
}

Room $RoomFromJson(Map<String, dynamic> json) {
	final Room room = Room();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		room.id = id;
	}
	final String? model = jsonConvert.convert<String>(json['model']);
	if (model != null) {
		room.model = model;
	}
	final String? code = jsonConvert.convert<String>(json['code']);
	if (code != null) {
		room.code = code;
	}
	final int? defaultPrice = jsonConvert.convert<int>(json['default_price']);
	if (defaultPrice != null) {
		room.defaultPrice = defaultPrice;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		room.title = title;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		room.description = description;
	}
	final int? beds = jsonConvert.convert<int>(json['beds']);
	if (beds != null) {
		room.beds = beds;
	}
	final int? guests = jsonConvert.convert<int>(json['guests']);
	if (guests != null) {
		room.guests = guests;
	}
	final int? bathrooms = jsonConvert.convert<int>(json['bathrooms']);
	if (bathrooms != null) {
		room.bathrooms = bathrooms;
	}
	return room;
}

Map<String, dynamic> $RoomToJson(Room entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['model'] = entity.model;
	data['code'] = entity.code;
	data['default_price'] = entity.defaultPrice;
	data['title'] = entity.title;
	data['description'] = entity.description;
	data['beds'] = entity.beds;
	data['guests'] = entity.guests;
	data['bathrooms'] = entity.bathrooms;
	return data;
}

Feature $FeatureFromJson(Map<String, dynamic> json) {
	final Feature feature = Feature();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		feature.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		feature.name = name;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		feature.url = url;
	}
	return feature;
}

Map<String, dynamic> $FeatureToJson(Feature entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['url'] = entity.url;
	return data;
}