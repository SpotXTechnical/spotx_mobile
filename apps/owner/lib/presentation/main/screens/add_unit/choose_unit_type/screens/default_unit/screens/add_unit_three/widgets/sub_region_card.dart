import 'package:flutter/material.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

class SubRegionCard extends StatelessWidget {
  const SubRegionCard({Key? key, required this.subRegion, required this.isSelected, required this.onItemSelected})
      : super(key: key);

  final Region subRegion;
  final bool isSelected;
  final Function(Region) onItemSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemSelected(subRegion);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(14))),
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(500)),
                    color:
                        isSelected ? Theme.of(context).primaryColorLight : Theme.of(context).scaffoldBackgroundColor),
              ),
              Column(
                children: [
                  const CustomClipRect(
                    borderRadius: BorderRadius.all(Radius.circular(17.6)),
                    width: 89,
                    height: 89,
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 12),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Text(
                        subRegion.name!,
                        style: circularBook(color: kWhite, fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}