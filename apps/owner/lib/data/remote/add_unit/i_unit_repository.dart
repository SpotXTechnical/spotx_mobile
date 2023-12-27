import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/utils/network/api_response.dart';
import 'model/unit.dart';

abstract class IUnitRepository {
  Future<ApiResponse> getFeatures();
  Future<ApiResponse> postUnit(Unit unit);
  Future<ApiResponse> postMedia(MediaFile mediaFile);
  Future<ApiResponse> getUnits(FilterQueries filterQueries);
  Future<ApiResponse> getUnitById(String id);
  Future<ApiResponse> deleteMedia(String id);
  Future<ApiResponse> getRooms(String unitId);
  Future<ApiResponse> deleteUnit(String id);
  Future<ApiResponse> updateUnit(Unit unit);
}
