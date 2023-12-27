import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';

import '../screens/unit_details/unit_details_screen.dart';

class HomeCampsWidget extends StatelessWidget {
  const HomeCampsWidget({
    Key? key,
    required this.camps,
  }) : super(key: key);

  final List<Unit> camps;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: isArabic ? const EdgeInsetsDirectional.only(end: 24, top: 28) : const EdgeInsetsDirectional.only(start: 24, top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.camps.tr(),
            style: circularMedium(color: kWhite, fontSize: 19),
          ),
          Container(
            margin: const EdgeInsets.only(top: 17),
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: camps.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(
                  indent: 15,
                );
              },
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: Container(
                  // width: state.regions?.length == 3
                  width: 3 == 3 ? (MediaQuery.of(context).size.width - 54) / 3 : (MediaQuery.of(context).size.width - 54) / 3.5,
                  decoration: BoxDecoration(color: Theme.of(context).unselectedWidgetColor, borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 57,
                        height: 57,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: Image.network(
                              camps[index].mainImage?.url ??
                                  "https://media.istockphoto.com/photos/colored-powder-explosion-on-black-background-picture-id1057506940?k=20&m=1057506940&s=612x612&w=0&h=3j5EA6YFVg3q-laNqTGtLxfCKVR3_o6gcVZZseNaWGk=",
                              fit: BoxFit.cover,
                            )),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            "${camps[index].title}",
                            style: circularMedium(color: kWhite, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  navigationKey.currentState?.pushNamed(UnitDetailsScreen.tag, arguments: camps[index].id);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}