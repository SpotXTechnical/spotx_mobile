import 'package:flutter/material.dart';
import 'package:owner/utils/widgets/app_buttons/app_button.dart';
import 'package:owner/utils/widgets/shimmer_skeleton.dart';

class UnitDetailsLoadingWidget extends StatelessWidget {
  const UnitDetailsLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerSkeleton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 17, start: 24, end: 24),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).hoverColor,
                  ),
                  height: 200,
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 19, start: 24, end: 24),
                  width: 50,
                  height: 25,
                  color: Theme.of(context).hoverColor,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsetsDirectional.only(top: 21, bottom: 21, start: 21, end: 21),
            decoration: BoxDecoration(
                color: Theme.of(context).hoverColor, borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: ShimmerSkeleton(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade900, borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: const Padding(
                        padding: EdgeInsetsDirectional.only(top: 14, bottom: 14),
                        child: Text(""),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900, borderRadius: const BorderRadius.all(Radius.circular(20))),
                        child: const Padding(
                          padding: EdgeInsetsDirectional.only(top: 14, bottom: 14),
                          child: Text(""),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900, borderRadius: const BorderRadius.all(Radius.circular(20))),
                        child: const Padding(
                          padding: EdgeInsetsDirectional.only(top: 14, bottom: 14),
                          child: Text(""),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),
          ShimmerSkeleton(
            child: Container(
              margin: const EdgeInsetsDirectional.only(top: 10, start: 24, end: 24),
              color: Theme.of(context).hoverColor,
              width: 100,
              height: 25,
            ),
          ),
          ShimmerSkeleton(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                  child: Container(
                    height: 106,
                    width: MediaQuery.of(context).size.width * .2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(13)),
                      color: Theme.of(context).hoverColor,
                    ),
                  ),
                ),
                Container(
                  height: 106,
                  width: MediaQuery.of(context).size.width * .2,
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(13)),
                    color: Theme.of(context).hoverColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 19),
            color: Theme.of(context).hoverColor,
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: ShimmerSkeleton(
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(start: 17),
                        height: 56,
                        color: Colors.transparent,
                        child: const AppButton(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(28)),
                          title: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
