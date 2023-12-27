import 'package:owner/data/remote/add_unit/model/unit.dart';

class UnitWithReference {
  final Unit? referenceUnit;
  final Unit updatedUnit;

  UnitWithReference({required this.updatedUnit, this.referenceUnit});
}
