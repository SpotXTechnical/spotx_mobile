import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/shimmer_skeleton.dart';

class OwnerUnitesLoadingWidget extends StatelessWidget {
  const OwnerUnitesLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: 24, end: 24, bottom: 20, top: 8),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Divider(indent: 20, color: Theme.of(context).backgroundColor);
        },
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ShimmerSkeleton(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 115,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsetsDirectional.only(top: 8, start: 5),
                                height: 18,
                                width: 55,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(
                                    top: 8, start: 5),
                                height: 18,
                                width: 75,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(
                                    top: 8, start: 5),
                                height: 18,
                                width: 120,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                      height: 25,
                                      width: 40,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 5),
                                      height: 25,
                                      width: 40,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 5),
                                      height: 25,
                                      width: 50,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 5),
                                      height: 25,
                                      width: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}