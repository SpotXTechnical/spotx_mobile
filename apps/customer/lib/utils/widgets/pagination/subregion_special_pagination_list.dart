import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';

class SubRegionSpecialPaginationList<T> extends StatefulWidget {
  const SubRegionSpecialPaginationList(
      {Key? key,
      required this.isLoading,
      required this.list,
      required this.hasMore,
      required this.loadMore,
      this.onRefresh,
      required this.builder,
      required this.loadingWidget,
      this.firstItemBuilder,
      this.divider = const Divider(),
      this.prefixLeadingWidget})
      : super(key: key);

  final bool isLoading;
  final List<T>? list;
  final bool hasMore;
  final Function loadMore;
  final Function? onRefresh;
  final Widget Function(T) builder;
  final Widget Function(T)? firstItemBuilder;
  final Widget loadingWidget;
  final Widget divider;
  final Widget? prefixLeadingWidget;
  @override
  _SubRegionSpecialPaginationListState<T> createState() => _SubRegionSpecialPaginationListState<T>();
}

class _SubRegionSpecialPaginationListState<T> extends State<SubRegionSpecialPaginationList<T>> {
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
        controller: scrollController,
        itemCount: (widget.list?.length ?? 0) + (widget.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == widget.list!.length && widget.hasMore) {
            return const LoadingWidget();
          } else if (widget.list == null) {
            return Container();
          }
          T item = widget.list![index];
          if (index == 0 && widget.firstItemBuilder != null) {
            return widget.firstItemBuilder!(item);
          }
          return widget.builder(item);
        },
        separatorBuilder: (BuildContext context, int index) {
          return widget.divider;
        },
      );
    }
    if (widget.prefixLeadingWidget != null) {
      listWidget = SingleChildScrollView(
        child: Column(
          children: [widget.prefixLeadingWidget!, listWidget],
        ),
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
