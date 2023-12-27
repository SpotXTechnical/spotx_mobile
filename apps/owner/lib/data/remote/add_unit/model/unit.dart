import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:owner/generated/json/unit.g.dart';

import 'package:owner/data/remote/add_unit/model/image_entity.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/add_unit/model/review_entity.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/generated/json/base/json_field.dart';

import 'feature_entity.dart';

@JsonSerializable()
class Unit extends Equatable {
  factory Unit.fromJson(Map<String, dynamic> json) => $UnitFromJson(json);

  Map<String, dynamic> toJson() => $UnitToJson(this);

  String? id;
  String? code;
  @JSONField(name: "default_price")
  String? defaultPrice;
  @JSONField(name: "current_price")
  String? currentPrice;
  String? title;
  @JSONField(name: "title_ar")
  String? titleAr;
  @JSONField(name: "title_en")
  String? titleEn;
  @JSONField(name: "description_ar")
  String? descriptionAr;
  @JSONField(name: "description_en")
  String? descriptionEn;
  String? description;
  String? longitude;
  String? latitude;
  @JSONField(name: "check_in")
  String? checkIn;
  @JSONField(name: "check_out")
  String? checkOut;
  @JSONField(name: "bed_rooms")
  String? bedRooms;
  String? beds;
  String? guests;
  @JSONField(name: "max_guests_number")
  String? maxNumberOfGuests;
  @JSONField(name: "bathrooms")
  String? bathRooms;
  @JSONField(name: "region_id")
  String? regionId;
  @JSONField(name: "address_ar")
  String? addressAr;
  @JSONField(name: "address_en")
  String? addressEn;
  String? address;
  @JSONField(name: "is_visible")
  int? isVisible;
  @JSONField(name: "is_families_only")
  int? isFamiliesOnly;
  List<int>? imagesIds;
  List<ImageEntity>? images;
  List<PriceRange>? ranges;
  List<Feature>? features;
  String? type;
  dynamic reservationsCount;
  List<Room>? rooms;
  List<Room>? models;
  @JSONField(name: "main_image")
  ImageEntity? mainImage;
  // references to to compared in state on edit
  List<int>? referenceImages;
  List<PriceRange>? referenceRanges;
  String? rate;
  List<Reservation>? reservations;
  List<ReviewEntity>? reviews;

  Unit({
    this.id,
    this.code,
    this.defaultPrice,
    this.titleAr,
    this.titleEn,
    this.descriptionAr,
    this.descriptionEn,
    this.longitude,
    this.latitude,
    this.checkIn,
    this.checkOut,
    this.bedRooms,
    this.beds,
    this.guests,
    this.bathRooms,
    this.regionId,
    this.addressAr,
    this.addressEn,
    this.isVisible,
    this.isFamiliesOnly,
    this.imagesIds,
    this.ranges,
    this.features,
    this.type,
    this.reservationsCount,
    this.title,
    this.rooms,
    this.description,
    this.address,
    this.models,
    this.referenceImages,
    this.referenceRanges,
    this.mainImage,
    this.rate,
    this.reservations,
    this.reviews,
    this.images,
    this.maxNumberOfGuests
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    code,
    defaultPrice,
    titleAr,
    titleEn,
    descriptionAr,
    descriptionEn,
    longitude,
    latitude,
    checkIn,
    checkOut,
    bedRooms,
    beds,
    guests,
    bathRooms,
    regionId,
    addressAr,
    addressEn,
    isVisible,
    isFamiliesOnly,
    imagesIds,
    ranges,
    features,
    type,
    reservationsCount,
    title,
    rooms,
    description,
    address,
    models,
    referenceImages,
    referenceRanges,
    mainImage,
    rate,
    reservations,
    reviews,
    maxNumberOfGuests
  ];

  Unit clone() {
    final String jsonString = json.encode(this);
    final jsonResponse = json.decode(jsonString);
    return Unit.fromJson(jsonResponse as Map<String, dynamic>);
  }
}

@JsonSerializable()
class Room extends Equatable {
  factory Room.fromJson(Map<String, dynamic> json) => $RoomFromJson(json);

  Map<String, dynamic> toJson() => $RoomToJson(this);

  String? id;
  String? model;
  String? code;
  String? title;
  @JSONField(name: "default_price")
  String? defaultPrice;
  @JSONField(name: "description_ar")
  String? descriptionAr;
  @JSONField(name: "description_en")
  String? descriptionEn;
  String? description;
  int? beds;
  int? guests;
  int? bathrooms;
  @JSONField(name: "ranges")
  List<PriceRange>? priceRanges;
  @JSONField(name: "rooms_number")
  int? count;
  List<int>? imagesIds;
  List<ImageEntity>? images;
  int? minRoomNumbers;
  List<Reservation>? reservations;
  List<ReviewEntity>? reviews;

  Room(
      {this.id,
      this.model,
      this.code,
      this.defaultPrice,
      this.descriptionAr,
      this.beds,
      this.guests,
      this.bathrooms,
      this.priceRanges,
      this.count,
      this.descriptionEn,
      this.imagesIds,
      this.images,
      this.description,
      this.minRoomNumbers,
      this.reservations,
      this.reviews,
      this.title});

  static List<Room>? createNewList(List<Room>? oldList) {
    List<Room>? newList = List.empty(growable: true);
    oldList?.forEach((element) {
      Room newElement = Room(
          id: element.id,
          model: element.model,
          code: element.code,
          defaultPrice: element.defaultPrice,
          descriptionAr: element.descriptionAr,
          beds: element.beds,
          guests: element.guests,
          bathrooms: element.bathrooms,
          priceRanges: element.priceRanges,
          count: element.count,
          imagesIds: element.imagesIds,
          descriptionEn: element.descriptionEn,
          description: element.description,
          images: element.images,
          minRoomNumbers: element.minRoomNumbers,
          reservations: Reservation.createNewReservationsList(element.reservations),
          reviews: element.reviews,
          title: element.title);
      newList.add(newElement);
    });
    return newList;
  }

  static bool isTheSameList(List<Room> oldList, List<Room> newList) {
    if (oldList.length != newList.length) {
      return false;
    }
    for (var oldElement in oldList) {
      for (var newElement in newList) {
        if (!isTheSameElement(oldElement, newElement)) {
          return false;
        }
      }
    }
    return true;
  }

  static bool isTheSameElement(Room oldElement, Room newElement) {
    return (oldElement.id == newElement.id &&
        oldElement.model == newElement.model &&
        oldElement.code == newElement.code &&
        oldElement.defaultPrice == newElement.defaultPrice &&
        oldElement.descriptionAr == newElement.descriptionAr &&
        oldElement.description == newElement.description &&
        oldElement.beds == newElement.beds &&
        oldElement.guests == newElement.guests &&
        oldElement.bathrooms == newElement.bathrooms &&
        oldElement.count == newElement.count &&
        oldElement.descriptionEn == newElement.descriptionEn &&
        oldElement.minRoomNumbers == newElement.minRoomNumbers &&
        oldElement.imagesIds == newElement.imagesIds &&
        oldElement.reviews?.length == newElement.reviews?.length &&
        oldElement.reservations?.length == newElement.reservations?.length &&
        oldElement.title == newElement.title &&
        PriceRange.isTheSameList(oldElement.priceRanges ?? List.empty(growable: false),
            newElement.priceRanges ?? List.empty(growable: false)));
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        model,
        code,
        defaultPrice,
        descriptionAr,
        beds,
        guests,
        bathrooms,
        priceRanges,
        count,
        descriptionEn,
        imagesIds,
        images,
        description,
        minRoomNumbers,
        reservations,
        reviews,
        title,
      ];
}