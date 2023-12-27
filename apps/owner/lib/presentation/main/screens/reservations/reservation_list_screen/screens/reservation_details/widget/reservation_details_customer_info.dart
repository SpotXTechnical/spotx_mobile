import 'package:flutter/material.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

class ReservationDetailsCustomerInfoWidget extends StatelessWidget {
  const ReservationDetailsCustomerInfoWidget({
    Key? key,
    required this.owner,
  }) : super(key: key);
  final User? owner;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 12, start: 24, end: 24),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.all(13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                    decoration: const BoxDecoration(),
                    child: CustomClipRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      width: 48,
                      height: 48,
                      path: owner?.image,
                    )),
                Expanded(
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(start: 9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          owner?.name ?? "",
                          style: circularBold(color: kWhite, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Theme.of(context).disabledColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(chatIconPath, color: kWhite),
                    )),
                onTap: () {
                  messageOwner(owner?.phone, context);
                },
              ),
              const SizedBox(
                width: 13,
              ),
              GestureDetector(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Theme.of(context).disabledColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(callIconPath, color: kWhite),
                    )),
                onTap: () {
                  callOwner(owner?.phone, context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}