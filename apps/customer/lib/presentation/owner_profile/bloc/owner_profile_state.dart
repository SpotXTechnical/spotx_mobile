import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

class OwnerProfileState extends Equatable {
  const OwnerProfileState(
      {this.units, this.isLoading = false, this.hasMore = false, this.owner, this.isUnitsLoading = false});
  final bool isLoading;
  final bool hasMore;
  final List<Unit>? units;
  final Owner? owner;
  final bool isUnitsLoading;
  @override
  List<Object?> get props => [units, hasMore, isLoading, isUnitsLoading];

  OwnerProfileState copyWith({bool? isLoading, bool? hasMore, List<Unit>? units, Owner? owner, bool? isUnitsLoading}) {
    return OwnerProfileState(
        isLoading: isLoading ?? this.isLoading,
        hasMore: hasMore ?? this.hasMore,
        units: units ?? this.units,
        owner: owner ?? this.owner,
        isUnitsLoading: isUnitsLoading ?? this.isUnitsLoading);
  }
}
