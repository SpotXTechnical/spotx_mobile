import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';

class ReservationDetailsViewDetailsWidget extends StatelessWidget {
  const ReservationDetailsViewDetailsWidget({Key? key, required this.stateWidget, required this.description})
      : super(key: key);

  final Text stateWidget;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 17, start: 24, end: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 10,
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  stateWidget,
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 10),
                    child: Text(
                      description,
                      style: circularBook(color: Theme.of(context).hintColor, fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 6,
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}