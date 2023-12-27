import 'package:flutter/material.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

class PaginationList<T> extends StatefulWidget {
  const PaginationList({
    Key? key,
    required this.isLoading,
    required this.list,
    required this.hasMore,
    required this.loadMore,
    this.onRefresh,
    required this.builder,
    required this.loadingWidget,
    this.divider
  }) : super(key: key);

  final bool isLoading;
  final List<T>? list;
  final bool hasMore;
  final Function loadMore;
  final Function? onRefresh;
  final Widget Function(T) builder;
  final Widget loadingWidget;
  final Widget? divider;
  @override
  _PaginationListState<T> createState() => _PaginationListState<T>();
}

class _PaginationListState<T> extends State<PaginationList<T>> {
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      debugPrint('scrollController scrollController.position.maxScrollExtent : ${scrollController.position.maxScrollExtent} , scrollController.offset: ${scrollController.offset}');
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        debugPrint('load more addListener called');
        if (widget.hasMore && !isLoadingMore) {
          debugPrint('load more dd called');
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
        controller: scrollController,
        itemCount: (widget.list?.length ?? 0) + (widget.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == widget.list!.length && widget.hasMore) {
            return const LoadingWidget();
          } else if (widget.list == null) {
            return Container();
          }
          T item = widget.list![index];
          return widget.builder(item);
        },
        separatorBuilder: (BuildContext context, int index) {
          return widget.divider ??
              Divider(
                color: Theme.of(context).scaffoldBackgroundColor,
              );
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
                child: listWidget
    )
            : listWidget;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
