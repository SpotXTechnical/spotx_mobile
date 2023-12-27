import 'package:spotx/generated/json/unit_response_entity.g.dart';

import 'package:spotx/data/remote/unit/model/image_entity.dart';
import 'package:spotx/data/remote/unit/model/review_entity.dart';
import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/utils/network/list_helper/links.dart';
import 'package:spotx/utils/network/list_helper/meta.dart';

@JsonSerializable()
class UnitResponseEntity {
  UnitResponseEntity();

  factory UnitResponseEntity.fromJson(Map<String, dynamic> json) => $UnitResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $UnitResponseEntityToJson(this);

  List<Unit>? data;
  Links? links;
  Meta? meta;
}

@JsonSerializable()
class Unit {
  factory Unit.fromJson(Map<String, dynamic> json) => $UnitFromJson(json);

  Map<String, dynamic> toJson() => $UnitToJson(this);

  int? id;
  String? code;
  @JSONField(name: "default_price")
  int? defaultPrice;
  @JSONField(name: "current_price")
  int? currentPrice;
  String? title;
  String? description;
  String? longitude;
  String? latitude;
  @JSONField(name: "check_in")
  String? checkIn;
  @JSONField(name: "check_out")
  String? checkOut;
  @JSONField(name: "bed_rooms")
  int? bedRooms;
  int? beds;
  int? guests;
  int? bathrooms;
  @JSONField(name: "region_id")
  int? regionId;
  String? address;
  @JSONField(name: "is_visible")
  int? isVisible;
  @JSONField(name: "reservations_count")
  dynamic? reservationsCount;
  @JSONField(name: "near_lower_price")
  dynamic? nearLowerPrice;
  String? type;
  @JSONField(name: "is_families_only")
  int? isFamiliesOnly;
  @JSONField(name: "active_ranges")
  List<ActiveRange>? activeRanges;
  @JSONField(name: "active_reservations")
  List<ActiveReservation>? activeReservations;
  List<ImageEntity>? images;
  List<ReviewEntity>? reviews;
  Owner? owner;
  @JSONField(name: "is_favourite")
  bool? isFavourite;
  @JSONField(name: "is_favourite")
  bool? uiIsFavourite;
  bool isFavouriteLoading;
  List<Room>? rooms;
  @JSONField(name: "avg_unit_rate")
  double? rate;
  List<Feature>? features;
  @JSONField(name: "main_image")
  ImageEntity? mainImage;
  @JSONField(name: "region_name")
  String? regionName;
  @JSONField(name: "sub_region_name")
  String? subRegionName;
  @JSONField(name: "discount_percentage")
  int? discountPercentage;
  Unit(
      {this.id,
      this.code,
      this.defaultPrice,
      this.title,
      this.description,
      this.longitude,
      this.latitude,
      this.checkIn,
      this.checkOut,
      this.bedRooms,
      this.beds,
      this.guests,
      this.bathrooms,
      this.regionId,
      this.address,
      this.isVisible,
      this.reservationsCount,
      this.nearLowerPrice,
      this.type,
      this.activeRanges,
      this.activeReservations,
      this.images,
      this.owner,
      this.rooms,
      this.isFavourite,
      this.uiIsFavourite,
      this.isFavouriteLoading = false,
      this.rate,
      this.features,
      this.mainImage,
      this.reviews,
      this.regionName,
      this.subRegionName,
      this.discountPercentage
      });

  static List<Unit> createNewUnitList(List<Unit>? list) {
    List<Unit> newList = List.empty(growable: true);
    list?.forEach((element) {
      Unit unit = Unit(
          id: element.id,
          code: element.code,
          defaultPrice: element.defaultPrice,
          title: element.title,
          description: element.description,
          longitude: element.longitude,
          latitude: element.latitude,
          checkIn: element.checkIn,
          checkOut: element.checkOut,
          bedRooms: element.bedRooms,
          beds: element.beds,
          guests: element.guests,
          bathrooms: element.bathrooms,
          regionId: element.regionId,
          address: element.address,
          isVisible: element.isVisible,
          reservationsCount: element.reservationsCount,
          nearLowerPrice: element.nearLowerPrice,
          type: element.type,
          activeRanges: element.activeRanges,
          activeReservations: element.activeReservations,
          images: element.images,
          owner: element.owner,
          isFavourite: element.isFavourite,
          uiIsFavourite: element.uiIsFavourite,
          isFavouriteLoading: element.isFavouriteLoading,
          rate: element.rate,
          features: element.features,
          rooms: element.rooms,
          mainImage: element.mainImage,
          reviews: element.reviews,
          regionName: element.regionName,
          subRegionName: element.subRegionName,
          discountPercentage: element.discountPercentage);

      newList.add(unit);
    });
    return newList;
  }

  static Unit createNewUnitObject(Unit element) {
    Unit unit = Unit(
        id: element.id,
        code: element.code,
        defaultPrice: element.defaultPrice,
        title: element.title,
        description: element.description,
        longitude: element.longitude,
        latitude: element.latitude,
        checkIn: element.checkIn,
        checkOut: element.checkOut,
        bedRooms: element.bedRooms,
        beds: element.beds,
        guests: element.guests,
        bathrooms: element.bathrooms,
        regionId: element.regionId,
        address: element.address,
        isVisible: element.isVisible,
        reservationsCount: element.reservationsCount,
        nearLowerPrice: element.nearLowerPrice,
        type: element.type,
        activeRanges: element.activeRanges,
        activeReservations: element.activeReservations,
        images: element.images,
        owner: element.owner,
        isFavourite: element.isFavourite,
        uiIsFavourite: element.uiIsFavourite,
        isFavouriteLoading: element.isFavouriteLoading,
        rate: element.rate,
        rooms: element.rooms,
        mainImage: element.mainImage,
        features: element.features,
        reviews: element.reviews,
        regionName: element.regionName,
        subRegionName: element.subRegionName,
        discountPercentage: element.discountPercentage);

    return unit;
  }
}

List<Unit> createNewListWithUpdatedUnit(List<Unit> list, Unit newUnit) {
  List<Unit> newList = List.empty(growable: true);
  for (var element in list) {
    Unit unit = Unit(
        id: element.id,
        code: element.code,
        defaultPrice: element.defaultPrice,
        title: element.title,
        description: element.description,
        longitude: element.longitude,
        latitude: element.latitude,
        checkIn: element.checkIn,
        checkOut: element.checkOut,
        bedRooms: element.bedRooms,
        beds: element.beds,
        guests: element.guests,
        bathrooms: element.bathrooms,
        regionId: element.regionId,
        address: element.address,
        isVisible: element.isVisible,
        reservationsCount: element.reservationsCount,
        nearLowerPrice: element.nearLowerPrice,
        type: element.type,
        activeRanges: element.activeRanges,
        activeReservations: element.activeReservations,
        images: element.images,
        owner: element.owner,
        features: element.features,
        rooms: element.rooms,
        rate: element.rate,
        mainImage: element.mainImage,
        isFavourite: element.id == newUnit.id ? newUnit.isFavourite : element.isFavourite,
        uiIsFavourite: element.id == newUnit.id ? newUnit.uiIsFavourite : element.uiIsFavourite,
        reviews: element.reviews,
        regionName: element.regionName,
        subRegionName: element.subRegionName,
        discountPercentage: element.discountPercentage,
        isFavouriteLoading: element.id == newUnit.id ? newUnit.isFavouriteLoading : element.isFavouriteLoading);
    newList.add(unit);
  }
  return newList;
}

@JsonSerializable()
class GetUnitResponseDataRegion {
  GetUnitResponseDataRegion();

  factory GetUnitResponseDataRegion.fromJson(Map<String, dynamic> json) => $GetUnitResponseDataRegionFromJson(json);

  Map<String, dynamic> toJson() => $GetUnitResponseDataRegionToJson(this);

  int? id;
  String? name;
  dynamic? description;
}

@JsonSerializable()
class GetUnitResponseMetaLinks {
  GetUnitResponseMetaLinks();

  factory GetUnitResponseMetaLinks.fromJson(Map<String, dynamic> json) => $GetUnitResponseMetaLinksFromJson(json);

  Map<String, dynamic> toJson() => $GetUnitResponseMetaLinksToJson(this);

  String? url;
  String? label;
  bool? active;
}

@JsonSerializable()
class ActiveRange {
  ActiveRange();

  factory ActiveRange.fromJson(Map<String, dynamic> json) => $ActiveRangeFromJson(json);

  Map<String, dynamic> toJson() => $ActiveRangeToJson(this);

  int? id;
  @JSONField(name: "rangable_type")
  String? rangableType;
  @JSONField(name: "rangable_id")
  int? rangableId;
  String? from;
  String? to;
  int? price;
  @JSONField(name: "is_offer")
  bool? isOffer;
  @JSONField(name: "created_at")
  String? createdAt;
  @JSONField(name: "updated_at")
  String? updatedAt;
  @JSONField(name: "from")
  DateTime? startDay;
  @JSONField(name: "to")
  DateTime? endDay;
  bool isComingFromOfferScreen = false;
}

@JsonSerializable()
class ActiveReservation {
  ActiveReservation();

  factory ActiveReservation.fromJson(Map<String, dynamic> json) => $ActiveReservationFromJson(json);

  Map<String, dynamic> toJson() => $ActiveReservationToJson(this);

  int? id;
  String? from;
  String? to;
  String? status;
  @JSONField(name: "reservable_type")
  String? reservableType;
  @JSONField(name: "reservable_id")
  int? reservableId;
  @JSONField(name: "userable_type")
  String? userableType;
  @JSONField(name: "userable_id")
  int? userableId;
  @JSONField(name: "total_price")
  int? totalPrice;
  @JSONField(name: "created_at")
  String? createdAt;
  @JSONField(name: "updated_at")
  String? updatedAt;
  @JSONField(name: "from")
  DateTime? startDay;
  @JSONField(name: "to")
  DateTime? endDay;

  ActiveReservation copyWith({
    int? id,
    String? from,
    String? to,
    String? status,
    String? reservableType,
    int? reservableId,
    String? userableType,
    int? userableId,
    int? totalPrice,
    String? createdAt,
    String? updatedAt,
    DateTime? startDay,
    DateTime? endDay,
  }) {
    return ActiveReservation()
      ..id = id ?? this.id
      ..from = from ?? this.from
      ..to = to ?? this.to
      ..status = status ?? this.status
      ..reservableType = reservableType ?? this.reservableType
      ..reservableId = reservableId ?? this.reservableId
      ..userableType = userableType ?? this.userableType
      ..userableId = userableId ?? this.userableId
      ..totalPrice = totalPrice ?? this.totalPrice
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..startDay = startDay ?? this.startDay
      ..endDay = endDay ?? this.endDay;
  }
}

@JsonSerializable()
class Owner {
  Owner();

  factory Owner.fromJson(Map<String, dynamic> json) => $OwnerFromJson(json);

  Map<String, dynamic> toJson() => $OwnerToJson(this);

  int? id;
  String? name;
  String? email;
  @JSONField(name: "email_verified_at")
  dynamic? emailVerifiedAt;
  String? phone;
  @JSONField(name: "phone_verified_at")
  dynamic? phoneVerifiedAt;
  dynamic? image;
  @JSONField(name: "national_id_image")
  dynamic? nationalIdImage;
  @JSONField(name: "national_id")
  String? nationalId;
  String? whatsapp;
  String? type;
}

@JsonSerializable()
class Room {
  Room();

  factory Room.fromJson(Map<String, dynamic> json) => $RoomFromJson(json);

  Map<String, dynamic> toJson() => $RoomToJson(this);

  int? id;
  String? model;
  String? code;
  @JSONField(name: "default_price")
  int? defaultPrice;
  String? title;
  String? description;
  int? beds;
  int? guests;
  int? bathrooms;
}

@JsonSerializable()
class Feature {
  Feature();

  factory Feature.fromJson(Map<String, dynamic> json) => $FeatureFromJson(json);

  Map<String, dynamic> toJson() => $FeatureToJson(this);

  int? id;
  String? name;
  String? url;
}

enum UnitType { camp, chalet }