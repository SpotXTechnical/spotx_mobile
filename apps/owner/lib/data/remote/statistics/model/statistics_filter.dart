import 'package:owner/data/remote/add_unit/model/unit.dart';

import '../../region/model/get_regions_response_entity.dart';

class StatisticsFilter {
  Unit? unit;
  Region? region;
  DateTime? startDate;
  DateTime? endData;
  StatisticsFilter({this.unit, this.region, this.startDate, this.endData});
}
