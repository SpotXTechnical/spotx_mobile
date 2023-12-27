import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/utils/extensions/string_extensions.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';

class RegionMediumCard extends StatelessWidget {
  const RegionMediumCard({Key? key, required this.region, required this.onTap}) : super(key: key);
  final Region region;
  final Function(Region) onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(region);
      },
      child: Container(
        width: 140,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                height: 80,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        20,
                      ),
                      topRight: Radius.circular(
                        20,
                      )),
                  child: (region.images?.isNotEmpty == true)
                      ? FadeInImage(
                          placeholder: const AssetImage(placeHolder),
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            region.images?[0].url.replaceHttps()??'',
                          ),
                        )
                      : const ErrorCard(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 140),
                alignment: AlignmentDirectional.center,
                child: Text(
                  "${region.name}",
                  style: circularMedium(color: kWhite, fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}