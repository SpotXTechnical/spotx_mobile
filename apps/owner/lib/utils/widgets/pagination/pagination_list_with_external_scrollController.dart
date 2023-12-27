import 'package:flutter/material.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

class PaginationListWithExternalScrollController<T> extends StatefulWidget {
  const PaginationListWithExternalScrollController(
      {Key? key,
      required this.isLoading,
      required this.list,
      required this.hasMore,
      required this.loadMore,
      this.onRefresh,
      required this.builder,
      required this.loadingWidget,
      this.divider = const Divider()})
      : super(key: key);

  final bool isLoading;
  final List<T>? list;
  final bool hasMore;
  final Function loadMore;
  final Function? onRefresh;
  final Widget Function(T) builder;
  final Widget loadingWidget;
  final Divider divider;
  @override
  _PaginationListWithExternalScrollControllerState<T> createState() =>
      _PaginationListWithExternalScrollControllerState<T>();
}

class _PaginationListWithExternalScrollControllerState<T> extends State<PaginationListWithExternalScrollController<T>> {
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        if (widget.hasMore && !isLoadingMore) {
          isLoadingMore = true;
          widget.loadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    isLoadingMore = false;
    Widget listWidget = Container();
    if (!widget.isLoading) {
      listWidget = ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: (widget.list?.length ?? 0) + (widget.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == widget.list!.length) {
            return const LoadingWidget();
          } else if (widget.list == null) {
            return Container();
          }
          T item = widget.list![index];
          return widget.builder(item);
        },
        separatorBuilder: (BuildContext context, int index) {
          return widget.divider;
        },
      );
    }
    return widget.isLoading
        ? widget.loadingWidget
        : widget.onRefresh != null
            ? RefreshIndicator(
                onRefresh: () async {
                  widget.onRefresh?.call();
                },
                child: listWidget)
            : listWidget;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
