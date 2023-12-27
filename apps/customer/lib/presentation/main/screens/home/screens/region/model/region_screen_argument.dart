import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';

class RegionScreenArguments {
  List<MiniRegion> regions;
  bool multiSelectMode;
  List<int>? selectedSubRegionsIds;
  bool isAllSubRegionsSelected;
  List<Region>? selectedSubRegions;

  RegionScreenArguments(
      {required this.regions,
      this.multiSelectMode = false,
      this.selectedSubRegionsIds,
      this.isAllSubRegionsSelected = false,
      this.selectedSubRegions});
}

class MiniRegion {
  int id;
  String name;

  MiniRegion(this.id, this.name);
}
