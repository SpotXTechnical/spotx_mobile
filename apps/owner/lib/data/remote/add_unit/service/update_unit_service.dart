import 'package:dio/dio.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';
import 'package:owner/utils/utils.dart';

class UpdateUnitService extends BaseService {
  Map<String, dynamic> formData = {};
  Future<ApiResponse> updateUnit(Unit unit) async {
    addAfterValidation("default_price", removeLeadingZeros(unit.defaultPrice));
    addAfterValidation("title_en", unit.titleEn);
    addAfterValidation("description_en", unit.descriptionEn);
    addAfterValidation("check_in", unit.checkIn);
    addAfterValidation("check_out", unit.checkOut);
    addAfterValidation("bed_rooms", unit.bedRooms);
    addAfterValidation("beds", unit.beds);
    addAfterValidation("region_id", unit.regionId);
    addAfterValidation("address_en", unit.addressEn);
    addAfterValidation("title_ar", unit.titleAr);
    addAfterValidation("description_ar", unit.descriptionAr);
    addAfterValidation("address_ar", unit.addressAr);
    addAfterValidation("bathrooms", unit.bathRooms);
    addAfterValidation("is_visible", unit.isVisible);
    addAfterValidation("type", unit.type);
    addAfterValidation("max_guests_number", unit.maxNumberOfGuests);
    addAfterValidation("is_families_only", unit.isFamiliesOnly);

    formData.addAll(addRooms(unit.models));
    formData.addAll(addImages(unit.imagesIds));
    bool isTheSameList = PriceRange.isTheSameList(unit.ranges, unit.referenceRanges);
    if (!isTheSameList) {
      formData.addAll(addRanges(unit.ranges));
    }
    formData.addAll(addFeatures(unit.features?.map((e) => e.id!).toList()));

    NetworkRequest request;
    String api = postUnitApi;
    formData["_method"] = "put";
    api = "$postUnitApi/${unit.id}";

    final FormData data = FormData.fromMap(formData);
    request = NetworkRequest(api, RequestMethod.post, headers: await getHeaders(), data: data);
    formData = {};
    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {}
    return result;
  }

  Map<String, dynamic> addImages(List<int>? images) {
    Map<String, dynamic> map = {};
    images?.asMap().forEach((key, value) {
      map["images[$key]"] = value;
    });
    return map;
  }

  Map<String, dynamic> addRanges(List<PriceRange>? ranges) {
    Map<String, dynamic> map = {};
    ranges?.asMap().forEach((key, value) {
      map["ranges[$key][from]"] = value.from;
      map["ranges[$key][to]"] = value.to;
      map["ranges[$key][price]"] = removeLeadingZeros(value.price);
      map["ranges[$key][is_offer]"] = value.isOffer;
    });
    return map;
  }

  Map<String, dynamic> addRoomRanges(List<PriceRange> ranges, int roomKey) {
    Map<String, dynamic> map = {};
    ranges.asMap().forEach((key, value) {
      map["models[$roomKey][ranges][$key][from]"] = value.from;
      map["models[$roomKey][ranges][$key][to]"] = value.to;
      map["models[$roomKey][ranges][$key][price]"] = removeLeadingZeros(value.price);
      map["models[$roomKey][ranges][$key][is_offer]"] = value.isOffer;
    });
    return map;
  }

  Map<String, dynamic> addRoomImages(List<int> images, int roomKey) {
    Map<String, dynamic> map = {};
    images.asMap().forEach((key, value) {
      map["models[$roomKey][images][$key]"] = value;
    });
    return map;
  }

  Map<String, dynamic> addRooms(List<Room>? rooms) {
    Map<String, dynamic> map = {};
    rooms?.asMap().forEach((key, value) {
      map["models[$key][model]"] = value.model;
      map.addAll(addRoomRanges(value.priceRanges!, key));
      map.addAll(addRoomImages(value.imagesIds!, key));
      map["models[$key][description_en]"] = value.descriptionEn;
      map["models[$key][description_ar]"] = value.descriptionAr;
      map["models[$key][default_price]"] = removeLeadingZeros(value.defaultPrice);
      map["models[$key][beds]"] = value.beds;
      map["models[$key][rooms_number]"] = value.count;
    });
    return map;
  }

  Map<String, dynamic> addFeatures(List<int>? featurs) {
    Map<String, dynamic> map = {};
    featurs?.asMap().forEach((key, value) {
      map["features[$key]"] = value;
    });
    return map;
  }

  void addAfterValidation(String key, dynamic value) {
    if (value != null) {
      formData[key] = value;
    }
  }
}
