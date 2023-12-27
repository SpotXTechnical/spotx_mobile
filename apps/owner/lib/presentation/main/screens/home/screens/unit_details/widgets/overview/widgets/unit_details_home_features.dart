import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/extensions/string_extensions.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

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
                    color: Theme.of(context).primaryColorDark, borderRadius: BorderRadius.all(Radius.circular(13))),
                padding: const EdgeInsets.all(13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: features[index].url == null
                            ? const ErrorCard()
                            : FadeInImage(
                                placeholder: const AssetImage(placeHolder),
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  features[index].url.replaceHttps(),
                                ))),
                    Expanded(
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        width: 50,
                        margin: const EdgeInsetsDirectional.only(top: 10),
                        child: AutoSizeText(
                          features[index].name!,
                          overflow: TextOverflow.ellipsis,
                          style: circularMedium(color: kWhite, fontSize: 13),
                          maxLines: 1,
                          minFontSize: 7,
                        ),
                      ),
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