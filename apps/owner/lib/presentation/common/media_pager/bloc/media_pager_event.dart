import 'package:equatable/equatable.dart';

abstract class MediaPagerEvent extends Equatable {}

class InitMediaPagerScreen extends MediaPagerEvent {
  InitMediaPagerScreen();

  @override
  List<Object?> get props => [];
}
