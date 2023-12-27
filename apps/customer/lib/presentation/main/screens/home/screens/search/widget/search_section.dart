import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotx/base/sub_region/region_event.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/common/search_region_bottom_sheet_modal.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';

class SearchSection extends StatelessWidget {
  const SearchSection(
      {Key? key,
      required this.onFilterTap,
      required this.onSortTap,
      required this.onItemSelected,
      required this.regions})
      : super(key: key);

  final Function? onFilterTap;
  final Function? onSortTap;
  final Function(List<Region>) onItemSelected;
  final List<Region>? regions;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 24, start: 24, top: 17),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(top: 12, start: 12),
            child: Text(
              LocaleKeys.discoverAndBook.tr(),
              style: circularMedium(color: kWhite, fontSize: 24),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 14, start: 12, end: 12),
            child: GestureDetector(
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 19),
                decoration: BoxDecoration(
                    color: Theme.of(context).unselectedWidgetColor, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    children: [
                      Image.asset(searchIconPath, color: kWhite),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(start: 10),
                          child: Text(
                            (regions?.isEmpty ?? true)
                                ? LocaleKeys.search.tr()
                                : '${regions?.map((region) => region.name).join(', ')}',
                            style: circularBook(
                                color: kWhite, fontSize: 13, textOverflow: TextOverflow.ellipsis),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                showSearchRegionBottomSheetModal(
                    context,
                    (p0, selectedRegions) => {if (selectedRegions != null) onItemSelected(selectedRegions)},
                    const LoadMoreRegions(),
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 60,
                  child: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10, top: 12, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(filterIconPath, color: kWhite),
                            const SizedBox(
                              width: 9,
                            ),
                            Text(
                              LocaleKeys.filter.tr(),
                              style: circularMedium(color: kWhite, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () => onFilterTap?.call(),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: VerticalDivider(
                    thickness: 1,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                ),
                Expanded(
                    flex: 60,
                    child: GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10, top: 12, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(sortIconPath, color: kWhite),
                              const SizedBox(
                                width: 9,
                              ),
                              Text(
                                LocaleKeys.sort.tr(),
                                style: circularMedium(color: kWhite, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () => onSortTap?.call(),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}