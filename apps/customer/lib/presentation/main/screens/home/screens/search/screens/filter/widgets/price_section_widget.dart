import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:spotx/data/remote/unit/model/unit_filter_config_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/extensions/build_context_extensions.dart';
import 'package:spotx/utils/style/theme.dart';

class PriceSectionWidget extends StatelessWidget {
  const PriceSectionWidget({
    Key? key,
    required this.rangeValues,
    required this.unitFilterConfigData,
    required this.addSetValuesRange,
  }) : super(key: key);

  final RangeValues rangeValues;
  final UnitFilterConfigEntity unitFilterConfigData;
  final Function(RangeValues) addSetValuesRange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 20, start: 23, end: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.price.tr(),
            style: circularBook(color: kWhite, fontSize: 17),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Theme.of(context).backgroundColor,
            ),
            height: 45,
            margin: const EdgeInsetsDirectional.only(top: 11),
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  child: Center(
                      child: Text(
                    LocaleKeys.minimumPrice.tr(),
                    style: circularBook(color: Theme.of(context).splashColor, fontSize: 16),
                  )),
                ),
                flex: 30,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: VerticalDivider(
                    thickness: 1,
                    color: cadetGrey,
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  child: Center(
                      child: Text(
                    rangeValues.start.toInt().replaceFarsiNumber(),
                    style: circularBook(color: Theme.of(context).splashColor, fontSize: 16),
                  )),
                ),
                flex: 30,
              )
            ]),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Theme.of(context).backgroundColor,
            ),
            height: 45,
            margin: const EdgeInsetsDirectional.only(top: 11),
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  child: Center(
                      child: Text(
                    LocaleKeys.maximumPrice.tr(),
                    style: circularBook(color: Theme.of(context).splashColor, fontSize: 16),
                  )),
                ),
                flex: 30,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: VerticalDivider(
                    thickness: 1,
                    color: cadetGrey,
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  child: Center(
                      child: Text(
                    rangeValues.end.toInt().replaceFarsiNumber(),
                    style: circularBook(color: Theme.of(context).splashColor, fontSize: 16),
                  )),
                ),
                flex: 30,
              )
            ]),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 12),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Theme.of(context).primaryColorLight,
                inactiveTrackColor: Theme.of(context).unselectedWidgetColor,
                thumbColor: Theme.of(context).primaryColorLight,
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
              ),
              child: RangeSlider(
                values: rangeValues,
                onChanged: (RangeValues value) {
                  addSetValuesRange(value);
                },
                min: unitFilterConfigData.minPrice!.toDouble(),
                max: unitFilterConfigData.maxPrice!.toDouble(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}