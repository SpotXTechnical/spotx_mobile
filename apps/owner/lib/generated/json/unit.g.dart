import 'package:owner/data/remote/add_unit/model/feature_entity.dart';
import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';

import 'package:owner/data/remote/add_unit/model/image_entity.dart';

import 'package:owner/data/remote/add_unit/model/range.dart';

import 'package:owner/data/remote/add_unit/model/review_entity.dart';

import 'package:owner/data/remote/reservation/model/reservation_entity.dart';



Unit $UnitFromJson(Map<String, dynamic> json) {
  final Unit unit = Unit();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    unit.id = id;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    unit.code = code;
  }
  final String? defaultPrice = jsonConvert.convert<String>(
      json['default_price']);
  if (defaultPrice != null) {
    unit.defaultPrice = defaultPrice;
  }
  final String? currentPrice = jsonConvert.convert<String>(
      json['current_price']);
  if (currentPrice != null) {
    unit.currentPrice = currentPrice;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    unit.title = title;
  }
  final String? titleAr = jsonConvert.convert<String>(json['title_ar']);
  if (titleAr != null) {
    unit.titleAr = titleAr;
  }
  final String? titleEn = jsonConvert.convert<String>(json['title_en']);
  if (titleEn != null) {
    unit.titleEn = titleEn;
  }
  final String? descriptionAr = jsonConvert.convert<String>(
      json['description_ar']);
  if (descriptionAr != null) {
    unit.descriptionAr = descriptionAr;
  }
  final String? descriptionEn = jsonConvert.convert<String>(
      json['description_en']);
  if (descriptionEn != null) {
    unit.descriptionEn = descriptionEn;
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
  final String? bedRooms = jsonConvert.convert<String>(json['bed_rooms']);
  if (bedRooms != null) {
    unit.bedRooms = bedRooms;
  }
  final String? beds = jsonConvert.convert<String>(json['beds']);
  if (beds != null) {
    unit.beds = beds;
  }
  final String? guests = jsonConvert.convert<String>(json['guests']);
  if (guests != null) {
    unit.guests = guests;
  }
  final String? maxNumberOfGuests = jsonConvert.convert<String>(
      json['max_guests_number']);
  if (maxNumberOfGuests != null) {
    unit.maxNumberOfGuests = maxNumberOfGuests;
  }
  final String? bathRooms = jsonConvert.convert<String>(json['bathrooms']);
  if (bathRooms != null) {
    unit.bathRooms = bathRooms;
  }
  final String? regionId = jsonConvert.convert<String>(json['region_id']);
  if (regionId != null) {
    unit.regionId = regionId;
  }
  final String? addressAr = jsonConvert.convert<String>(json['address_ar']);
  if (addressAr != null) {
    unit.addressAr = addressAr;
  }
  final String? addressEn = jsonConvert.convert<String>(json['address_en']);
  if (addressEn != null) {
    unit.addressEn = addressEn;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    unit.address = address;
  }
  final int? isVisible = jsonConvert.convert<int>(json['is_visible']);
  if (isVisible != null) {
    unit.isVisible = isVisible;
  }
  final int? isFamiliesOnly = jsonConvert.convert<int>(
      json['is_families_only']);
  if (isFamiliesOnly != null) {
    unit.isFamiliesOnly = isFamiliesOnly;
  }
  final List<int>? imagesIds = (json['imagesIds'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (imagesIds != null) {
    unit.imagesIds = imagesIds;
  }
  final List<ImageEntity>? images = (json['images'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ImageEntity>(e) as ImageEntity).toList();
  if (images != null) {
    unit.images = images;
  }
  final List<PriceRange>? ranges = (json['ranges'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<PriceRange>(e) as PriceRange).toList();
  if (ranges != null) {
    unit.ranges = ranges;
  }
  final List<Feature>? features = (json['features'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<Feature>(e) as Feature).toList();
  if (features != null) {
    unit.features = features;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    unit.type = type;
  }
  final dynamic reservationsCount = json['reservationsCount'];
  if (reservationsCount != null) {
    unit.reservationsCount = reservationsCount;
  }
  final List<Room>? rooms = (json['rooms'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<Room>(e) as Room).toList();
  if (rooms != null) {
    unit.rooms = rooms;
  }
  final List<Room>? models = (json['models'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<Room>(e) as Room).toList();
  if (models != null) {
    unit.models = models;
  }
  final ImageEntity? mainImage = jsonConvert.convert<ImageEntity>(
      json['main_image']);
  if (mainImage != null) {
    unit.mainImage = mainImage;
  }
  final List<int>? referenceImages = (json['referenceImages'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (referenceImages != null) {
    unit.referenceImages = referenceImages;
  }
  final List<PriceRange>? referenceRanges = (json['referenceRanges'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<PriceRange>(e) as PriceRange).toList();
  if (referenceRanges != null) {
    unit.referenceRanges = referenceRanges;
  }
  final String? rate = jsonConvert.convert<String>(json['rate']);
  if (rate != null) {
    unit.rate = rate;
  }
  final List<Reservation>? reservations = (json['reservations'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<Reservation>(e) as Reservation).toList();
  if (reservations != null) {
    unit.reservations = reservations;
  }
  final List<ReviewEntity>? reviews = (json['reviews'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ReviewEntity>(e) as ReviewEntity).toList();
  if (reviews != null) {
    unit.reviews = reviews;
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
  data['title_ar'] = entity.titleAr;
  data['title_en'] = entity.titleEn;
  data['description_ar'] = entity.descriptionAr;
  data['description_en'] = entity.descriptionEn;
  data['description'] = entity.description;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['check_in'] = entity.checkIn;
  data['check_out'] = entity.checkOut;
  data['bed_rooms'] = entity.bedRooms;
  data['beds'] = entity.beds;
  data['guests'] = entity.guests;
  data['max_guests_number'] = entity.maxNumberOfGuests;
  data['bathrooms'] = entity.bathRooms;
  data['region_id'] = entity.regionId;
  data['address_ar'] = entity.addressAr;
  data['address_en'] = entity.addressEn;
  data['address'] = entity.address;
  data['is_visible'] = entity.isVisible;
  data['is_families_only'] = entity.isFamiliesOnly;
  data['imagesIds'] = entity.imagesIds;
  data['images'] = entity.images?.map((v) => v.toJson()).toList();
  data['ranges'] = entity.ranges?.map((v) => v.toJson()).toList();
  data['features'] = entity.features?.map((v) => v.toJson()).toList();
  data['type'] = entity.type;
  data['reservationsCount'] = entity.reservationsCount;
  data['rooms'] = entity.rooms?.map((v) => v.toJson()).toList();
  data['models'] = entity.models?.map((v) => v.toJson()).toList();
  data['main_image'] = entity.mainImage?.toJson();
  data['referenceImages'] = entity.referenceImages;
  data['referenceRanges'] =
      entity.referenceRanges?.map((v) => v.toJson()).toList();
  data['rate'] = entity.rate;
  data['reservations'] = entity.reservations?.map((v) => v.toJson()).toList();
  data['reviews'] = entity.reviews?.map((v) => v.toJson()).toList();
  return data;
}

extension UnitExt on Unit {
  Unit copyWith({
    String? id,
    String? code,
    String? defaultPrice,
    String? currentPrice,
    String? title,
    String? titleAr,
    String? titleEn,
    String? descriptionAr,
    String? descriptionEn,
    String? description,
    String? longitude,
    String? latitude,
    String? checkIn,
    String? checkOut,
    String? bedRooms,
    String? beds,
    String? guests,
    String? maxNumberOfGuests,
    String? bathRooms,
    String? regionId,
    String? addressAr,
    String? addressEn,
    String? address,
    int? isVisible,
    int? isFamiliesOnly,
    List<int>? imagesIds,
    List<ImageEntity>? images,
    List<PriceRange>? ranges,
    List<Feature>? features,
    String? type,
    dynamic reservationsCount,
    List<Room>? rooms,
    List<Room>? models,
    ImageEntity? mainImage,
    List<int>? referenceImages,
    List<PriceRange>? referenceRanges,
    String? rate,
    List<Reservation>? reservations,
    List<ReviewEntity>? reviews,
  }) {
    return Unit()
      ..id = id ?? this.id
      ..code = code ?? this.code
      ..defaultPrice = defaultPrice ?? this.defaultPrice
      ..currentPrice = currentPrice ?? this.currentPrice
      ..title = title ?? this.title
      ..titleAr = titleAr ?? this.titleAr
      ..titleEn = titleEn ?? this.titleEn
      ..descriptionAr = descriptionAr ?? this.descriptionAr
      ..descriptionEn = descriptionEn ?? this.descriptionEn
      ..description = description ?? this.description
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..checkIn = checkIn ?? this.checkIn
      ..checkOut = checkOut ?? this.checkOut
      ..bedRooms = bedRooms ?? this.bedRooms
      ..beds = beds ?? this.beds
      ..guests = guests ?? this.guests
      ..maxNumberOfGuests = maxNumberOfGuests ?? this.maxNumberOfGuests
      ..bathRooms = bathRooms ?? this.bathRooms
      ..regionId = regionId ?? this.regionId
      ..addressAr = addressAr ?? this.addressAr
      ..addressEn = addressEn ?? this.addressEn
      ..address = address ?? this.address
      ..isVisible = isVisible ?? this.isVisible
      ..isFamiliesOnly = isFamiliesOnly ?? this.isFamiliesOnly
      ..imagesIds = imagesIds ?? this.imagesIds
      ..images = images ?? this.images
      ..ranges = ranges ?? this.ranges
      ..features = features ?? this.features
      ..type = type ?? this.type
      ..reservationsCount = reservationsCount ?? this.reservationsCount
      ..rooms = rooms ?? this.rooms
      ..models = models ?? this.models
      ..mainImage = mainImage ?? this.mainImage
      ..referenceImages = referenceImages ?? this.referenceImages
      ..referenceRanges = referenceRanges ?? this.referenceRanges
      ..rate = rate ?? this.rate
      ..reservations = reservations ?? this.reservations
      ..reviews = reviews ?? this.reviews;
  }
}

Room $RoomFromJson(Map<String, dynamic> json) {
  final Room room = Room();
  final String? id = jsonConvert.convert<String>(json['id']);
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
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    room.title = title;
  }
  final String? defaultPrice = jsonConvert.convert<String>(
      json['default_price']);
  if (defaultPrice != null) {
    room.defaultPrice = defaultPrice;
  }
  final String? descriptionAr = jsonConvert.convert<String>(
      json['description_ar']);
  if (descriptionAr != null) {
    room.descriptionAr = descriptionAr;
  }
  final String? descriptionEn = jsonConvert.convert<String>(
      json['description_en']);
  if (descriptionEn != null) {
    room.descriptionEn = descriptionEn;
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
  final List<PriceRange>? priceRanges = (json['ranges'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<PriceRange>(e) as PriceRange).toList();
  if (priceRanges != null) {
    room.priceRanges = priceRanges;
  }
  final int? count = jsonConvert.convert<int>(json['rooms_number']);
  if (count != null) {
    room.count = count;
  }
  final List<int>? imagesIds = (json['imagesIds'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (imagesIds != null) {
    room.imagesIds = imagesIds;
  }
  final List<ImageEntity>? images = (json['images'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ImageEntity>(e) as ImageEntity).toList();
  if (images != null) {
    room.images = images;
  }
  final int? minRoomNumbers = jsonConvert.convert<int>(json['minRoomNumbers']);
  if (minRoomNumbers != null) {
    room.minRoomNumbers = minRoomNumbers;
  }
  final List<Reservation>? reservations = (json['reservations'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<Reservation>(e) as Reservation).toList();
  if (reservations != null) {
    room.reservations = reservations;
  }
  final List<ReviewEntity>? reviews = (json['reviews'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ReviewEntity>(e) as ReviewEntity).toList();
  if (reviews != null) {
    room.reviews = reviews;
  }
  return room;
}

Map<String, dynamic> $RoomToJson(Room entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['model'] = entity.model;
  data['code'] = entity.code;
  data['title'] = entity.title;
  data['default_price'] = entity.defaultPrice;
  data['description_ar'] = entity.descriptionAr;
  data['description_en'] = entity.descriptionEn;
  data['description'] = entity.description;
  data['beds'] = entity.beds;
  data['guests'] = entity.guests;
  data['bathrooms'] = entity.bathrooms;
  data['ranges'] = entity.priceRanges?.map((v) => v.toJson()).toList();
  data['rooms_number'] = entity.count;
  data['imagesIds'] = entity.imagesIds;
  data['images'] = entity.images?.map((v) => v.toJson()).toList();
  data['minRoomNumbers'] = entity.minRoomNumbers;
  data['reservations'] = entity.reservations?.map((v) => v.toJson()).toList();
  data['reviews'] = entity.reviews?.map((v) => v.toJson()).toList();
  return data;
}

extension RoomExt on Room {
  Room copyWith({
    String? id,
    String? model,
    String? code,
    String? title,
    String? defaultPrice,
    String? descriptionAr,
    String? descriptionEn,
    String? description,
    int? beds,
    int? guests,
    int? bathrooms,
    List<PriceRange>? priceRanges,
    int? count,
    List<int>? imagesIds,
    List<ImageEntity>? images,
    int? minRoomNumbers,
    List<Reservation>? reservations,
    List<ReviewEntity>? reviews,
  }) {
    return Room()
      ..id = id ?? this.id
      ..model = model ?? this.model
      ..code = code ?? this.code
      ..title = title ?? this.title
      ..defaultPrice = defaultPrice ?? this.defaultPrice
      ..descriptionAr = descriptionAr ?? this.descriptionAr
      ..descriptionEn = descriptionEn ?? this.descriptionEn
      ..description = description ?? this.description
      ..beds = beds ?? this.beds
      ..guests = guests ?? this.guests
      ..bathrooms = bathrooms ?? this.bathrooms
      ..priceRanges = priceRanges ?? this.priceRanges
      ..count = count ?? this.count
      ..imagesIds = imagesIds ?? this.imagesIds
      ..images = images ?? this.images
      ..minRoomNumbers = minRoomNumbers ?? this.minRoomNumbers
      ..reservations = reservations ?? this.reservations
      ..reviews = reviews ?? this.reviews;
  }
}