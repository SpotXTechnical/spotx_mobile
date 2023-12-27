import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:spotx/data/local/MediaIPagerEntity.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';
import 'package:spotx/presentation/common/media_pager/widget/video_player.dart';
import 'package:spotx/utils/extensions/string_extensions.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:photo_view/photo_view.dart';
import 'bloc/media_pager_bloc.dart';
import 'bloc/media_pager_state.dart';

class MediaPagerScreen extends StatelessWidget {
  const MediaPagerScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "MediaPagerScreen";
  @override
  Widget build(BuildContext context) {
    final mediaPagerEntity = ModalRoute.of(context)!.settings.arguments as MediaPagerEntity;
    final PageController controller = PageController();
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.animateToPage(
          mediaPagerEntity.images.indexWhere((element) => element.id == mediaPagerEntity.selectedImage.id),
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear);
    });

    return BlocProvider<MediaPagerBloc>(
      create: (ctx) => MediaPagerBloc(),
      child: BlocBuilder<MediaPagerBloc, MediaPagerState>(
        builder: (context, state) {
          return CustomSafeArea(
              child: CustomScaffold(
                  appBar: const PreferredSize(
                    preferredSize: Size.fromHeight(60),
                    child: Header(),
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: PageView(
                      controller: controller,
                      children: buildPages(mediaPagerEntity.images, context),
                    ),
                  )));
        },
      ),
    );
  }
}

List<Widget> buildPages(List<ImageEntity> mediaList, BuildContext context) {
  List<Widget> widgets = List.empty(growable: true);
  for (var element in mediaList) {
    switch (element.type) {
      case imageType:
        widgets.add(PhotoView(
          imageProvider: CachedNetworkImageProvider(element.url.replaceHttps()),
          backgroundDecoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        ));
        break;
      case videoType:
        widgets.add(VideoPlayerWidget(videoPath: element.url??''));
        break;

      default:
        widgets.add(PhotoView(
          imageProvider: CachedNetworkImageProvider(element.url.replaceHttps()),
          backgroundDecoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        ));
        break;
    }
  }
  return widgets;
}
