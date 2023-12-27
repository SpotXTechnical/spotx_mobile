import 'package:flutter/material.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';

class OwnerDetails extends StatelessWidget {
  const OwnerDetails({
    Key? key,
    required this.owner,
  }) : super(key: key);
  final Owner owner;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 12, start: 24, end: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              decoration: const BoxDecoration(),
              child: CustomClipRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                width: 48,
                height: 48,
                path: owner.image,
              )),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 9, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  owner.name ?? "Empty Data",
                  style: circularBold(color: Theme.of(context).hintColor, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}