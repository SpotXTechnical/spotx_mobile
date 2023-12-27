import 'package:owner/data/remote/add_unit/model/image_entity.dart';

class MediaPagerEntity {
  final List<ImageEntity> images;
  final ImageEntity selectedImage;
  MediaPagerEntity(this.images, this.selectedImage);
}
