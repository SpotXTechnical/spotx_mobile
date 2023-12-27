import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';

class PaginationGrid<T> extends StatefulWidget {
  const PaginationGrid(
      {Key? key,
      required this.isLoading,
      required this.list,
      required this.hasMore,
      required this.loadMore,
      this.onRefresh,
      required this.builder,
      required this.loadingWidget,
      this.divider = const Divider(),
      this.loadMoreLoading = const LoadingWidget()})
      : super(key: key);

  final bool isLoading;
  final List<T>? list;
  final bool hasMore;
  final Function loadMore;
  final Function? onRefresh;
  final Widget Function(T) builder;
  final Widget loadingWidget;
  final Divider divider;
  final Widget? loadMoreLoading;
  @override
  _PaginationGridState<T> createState() => _PaginationGridState<T>();
}

class _PaginationGridState<T> extends State<PaginationGrid<T>> {
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
      listWidget = GridView.builder(
          shrinkWrap: true,
          controller: scrollController,
          itemCount: (widget.list?.length ?? 0) + (widget.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == widget.list!.length) {
              return const LoadingWidget();
            } else if (widget.list == null) {
              return Wrap(children: [Container()]);
            }
            T item = widget.list![index];
            return widget.builder(item);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20));
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
