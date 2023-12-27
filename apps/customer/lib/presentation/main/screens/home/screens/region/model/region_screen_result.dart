import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';

class RegionScreenResult {
  List<int>? selectedSubRegionsIds;
  List<Region>? selectedSubRegions;
  bool isAllSubRegionsSelected;

  RegionScreenResult(this.selectedSubRegionsIds, this.isAllSubRegionsSelected,{this.selectedSubRegions});
}
