import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

class AddPaymentState extends Equatable {
  const AddPaymentState(
      {this.units,
      this.date,
      this.selectedUnit,
      this.isUnitsLoading = false,
      this.hasUnit = true,
      this.isLoading = false});

  final bool isUnitsLoading;
  final List<Unit>? units;
  final Unit? selectedUnit;
  final String? date;
  final bool hasUnit;
  final bool isLoading;

  @override
  List<Object?> get props => [units, date, isUnitsLoading, selectedUnit, hasUnit, isLoading];

  AddPaymentState copyWith(
      {List<Unit>? units, bool? isUnitsLoading, Unit? selectedUnit, String? date, bool? hasUnit, bool? isLoading}) {
    return AddPaymentState(
        units: units ?? this.units,
        isUnitsLoading: isUnitsLoading ?? this.isUnitsLoading,
        selectedUnit: selectedUnit ?? this.selectedUnit,
        date: date ?? this.date,
        hasUnit: hasUnit ?? this.hasUnit,
        isLoading: isLoading ?? this.isLoading);
  }
}
