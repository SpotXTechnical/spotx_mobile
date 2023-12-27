import 'package:flutter/material.dart';
import 'package:owner/utils/widgets/shimmer_skeleton.dart';

class ReservationCardShimmer extends StatelessWidget {
  const ReservationCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).hoverColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)
        ),
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
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(top: 8, start: 5),
                              height: 18,
                              width: 55,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(top: 8, start: 5),
                            height: 18,
                            width: 75,
                            color: Colors.grey.shade200,
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(top: 8, start: 5),
                            height: 18,
                            width: 120,
                            color: Colors.grey.shade200,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    color: Colors.grey.shade200,
                                  ),
                                  height: 25,
                                  width: 40,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    color: Colors.grey.shade200,
                                  ),
                                  margin: const EdgeInsetsDirectional.only(start: 5),
                                  height: 25,
                                  width: 40,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    color: Colors.grey.shade200,
                                  ),
                                  margin: const EdgeInsetsDirectional.only(start: 5),
                                  height: 25,
                                  width: 50,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    color: Colors.grey.shade200,
                                  ),
                                  margin: const EdgeInsetsDirectional.only(start: 5),
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
    );
  }
}
