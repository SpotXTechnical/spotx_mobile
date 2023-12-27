import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/data/remote/add_unit/service/delete_media_service.dart';
import 'package:owner/data/remote/add_unit/service/delete_unit_service.dart';
import 'package:owner/data/remote/add_unit/service/get_features_service.dart';
import 'package:owner/data/remote/add_unit/service/get_rooms_service.dart';
import 'package:owner/data/remote/add_unit/service/get_unit_by_id_service.dart';
import 'package:owner/data/remote/add_unit/service/get_units_service.dart';
import 'package:owner/data/remote/add_unit/service/post_image_service.dart';
import 'package:owner/data/remote/add_unit/service/post_unit_service.dart';
import 'package:owner/data/remote/add_unit/service/update_unit_service.dart';
import 'package:owner/utils/network/api_response.dart';

import 'model/unit.dart';

class UnitRepository implements IUnitRepository {
  final GetFeaturesService _featuresService = GetFeaturesService();
  final PostUnitService _postUnitService = PostUnitService();
  final PostMediaService _postMediaService = PostMediaService();
  final GetUnitsService _getUnitsService = GetUnitsService();
  final GetUnitByIdService _getUnitDetailsService = GetUnitByIdService();
  final DeleteMediaService _deleteMediaService = DeleteMediaService();
  final GetRoomsService _getRoomsService = GetRoomsService();
  final DeleteUnitService _deleteUnitService = DeleteUnitService();
  final UpdateUnitService _updateUnitService = UpdateUnitService();

  @override
  Future<ApiResponse> getFeatures() {
    return _featuresService.getFeatures();
  }

  @override
  Future<ApiResponse> postUnit(Unit unit) {
    return _postUnitService.postUnit(unit);
  }

  @override
  Future<ApiResponse> postMedia(MediaFile mediaFile) {
    return _postMediaService.postMedia(mediaFile);
  }

  @override
  Future<ApiResponse> getUnits(FilterQueries filterQueries) {
    return _getUnitsService.getUnits(filterQueries);
  }

  @override
  Future<ApiResponse> getUnitById(String id) {
    return _getUnitDetailsService.getUnitById(id);
  }

  @override
  Future<ApiResponse> deleteMedia(String id) {
    return _deleteMediaService.deleteMedia(id);
  }

  @override
  Future<ApiResponse> getRooms(String unitId) {
    return _getRoomsService.getRooms(unitId);
  }

  @override
  Future<ApiResponse> deleteUnit(String id) {
    return _deleteUnitService.deleteUnit(id);
  }

  @override
  Future<ApiResponse> updateUnit(Unit unit) {
    return _updateUnitService.updateUnit(unit);
  }
}
