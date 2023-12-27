import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';

class FilterBlocUtils {
  static List<Region> getRegions(List<int> selectedRegionsIds, List<Region> regions) {
    List<Region> selectedRegions = List.empty(growable: true);
    regions.forEach((region) {
      selectedRegionsIds.forEach((regionId) {
        if (region.id == regionId) {
          selectedRegions.add(region);
        }
      });
    });
    return selectedRegions;
  }

  static int getRegionsSubRegionsCount(List<int> selectedRegionsIds, List<Region> regions) {
    List<Region> selectedRegions = FilterBlocUtils.getRegions(selectedRegionsIds, regions);
    int subRegionsCount = 0;
    selectedRegions.forEach((element) {
      if (element.subRegions != null && element.subRegions!.isNotEmpty) {
        subRegionsCount = subRegionsCount + element.subRegions!.length;
      }
    });
    return subRegionsCount;
  }

  static int? getRemovedRegionId(List<int> newRegionList, List<int> selectedRegionList) {
    int? removedRegionId;
    for (var element in selectedRegionList) {
      if (!newRegionList.contains(element)) {
        removedRegionId = element;
      }
    }
    return removedRegionId;
  }

  static void separateRegionsAndSubRegionsIds(FilterQueries filterQueries, List<Region> selectedRegions,
      List<Region> selectedSubRegions, List<Region> allRegions) {
    for (var filterRegion in filterQueries.regions) {
      if (allRegions.map((e) => e.id).toList().contains(filterRegion.id)) {
        selectedRegions.add(filterRegion);
      } else {
        selectedSubRegions.add(filterRegion);
      }
    }
  }
}
