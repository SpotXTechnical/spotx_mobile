import 'package:spotx/base/base_bloc.dart';

import 'media_pager_event.dart';
import 'media_pager_state.dart';

class MediaPagerBloc extends BaseBloc<MediaPagerEvent, MediaPagerState> {
  MediaPagerBloc() : super(const MediaPagerState()) {}
}
