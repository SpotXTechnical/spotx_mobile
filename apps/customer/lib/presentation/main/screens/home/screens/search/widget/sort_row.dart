import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/utils/const.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';

class SortRow extends StatelessWidget {
  const SortRow({Key? key, required this.index, required this.sortType, required this.selectedSortType, required this.changeSortType})
      : super(key: key);

  final int index;
  final String sortType;
  final String selectedSortType;
  final Function(String) changeSortType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsetsDirectional.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sortType,
                  style: circularBook(color: Theme.of(context).hintColor, fontSize: 16),
                ),
                if (selectedSortType == sortType) Image.asset(checkMarkIconPath, color: kWhite)
              ],
            ),
            if (sortTypes.length - 1 != index)
              Container(
                margin: const EdgeInsetsDirectional.only(top: 16),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Theme.of(context).unselectedWidgetColor,
              )
          ],
        ),
      ),
      onTap: () {
        if (selectedSortType != sortType) {
          changeSortType(sortType);
        }
        Navigator.of(context).pop();
      },
    );
  }
}