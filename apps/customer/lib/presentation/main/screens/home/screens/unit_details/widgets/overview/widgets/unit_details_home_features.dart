import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';
import 'package:spotx/utils/widgets/cached_image_widget.dart';

class UnitDetailsHomeFeatures extends StatelessWidget {
  const UnitDetailsHomeFeatures({Key? key, required this.features}) : super(key: key);
  final List<Feature> features;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsetsDirectional.only(start: 24, top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.homeFeatures.tr(),
            style: circularMedium(color: kWhite, fontSize: 19),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 17),
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: features.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(
                  indent: 15,
                );
              },
              itemBuilder: (BuildContext context, int index) => Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: const BorderRadius.all(Radius.circular(13))),
                padding: const EdgeInsets.all(13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: features[index].url == null
                          ? const ErrorCard()
                          : CachedImageWidget(
                              fit: BoxFit.fill,
                              placeholder: placeHolder,
                              imageUrl: features.elementAt(index).url ?? "",
                            ),
                    ),
                    Expanded(
                      child: Container(
                          width: 50,
                          alignment: AlignmentDirectional.center,
                          margin: const EdgeInsetsDirectional.only(top: 10),
                          child: AutoSizeText(
                            features[index].name!,
                            overflow: TextOverflow.ellipsis,
                            style: circularMedium(color: kWhite, fontSize: 13),
                            maxLines: 1,
                            minFontSize: 7,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}