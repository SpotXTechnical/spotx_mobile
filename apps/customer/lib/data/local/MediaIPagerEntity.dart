import 'package:spotx/data/remote/unit/model/image_entity.dart';

class MediaPagerEntity {
  final List<ImageEntity> images;
  final ImageEntity selectedImage;
  MediaPagerEntity(this.images, this.selectedImage);
}
