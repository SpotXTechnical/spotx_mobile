import 'package:equatable/equatable.dart';

abstract class SubregionEvent extends Equatable {
  const SubregionEvent();
}

class GetSubRegions extends SubregionEvent {
  final String regionId;
  final bool loadMore;
  final String? searchQuery;

  const GetSubRegions({required this.regionId, this.loadMore = false, this.searchQuery});

  @override
  List<Object?> get props => [
        regionId,
        loadMore,
      ];
}

class LoadMoreSubRegions extends SubregionEvent {
  final String regionId;

  const LoadMoreSubRegions({
    required this.regionId,
  });

  @override
  List<Object?> get props => [
        regionId,
      ];
}
