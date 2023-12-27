import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/room/widgets/image_footer_section.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/show_resource_type_bottom_sheet_widget.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/utils.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/bloc/media_bloc.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/bloc/media_event.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/bloc/media_state.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_second_screen/bloc/edit_unit_second_state.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';

class ImageUploadSection extends StatelessWidget {
  const ImageUploadSection(
      {Key? key,
      required this.mediaFiles,
      required this.deleteFileLocallyAction,
      required this.addFilesAction,
      required this.loadingMediaAction,
      this.imageError,
      this.isEdit = false})
      : super(key: key);
  final List<MediaFile> mediaFiles;
  final Function(MediaFile) deleteFileLocallyAction;
  final Function(List<MediaFile>) addFilesAction;
  final Function(String) loadingMediaAction;
  final ImageError? imageError;
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  LocaleKeys.uploadImagesAndVideos.tr(),
                  style: circularMedium(color: Theme.of(context).hintColor, fontSize: 14),
                  overflow: TextOverflow.fade,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  LocaleKeys.upTo10ImagesAndOneVideo.tr(),
                  style: circularMedium(color: Theme.of(context).primaryColorLight, fontSize: 12),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 24, top: 11),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BlocProvider<MediaBloc>(
              create: (ctx) => MediaBloc(UnitRepository()),
              child: BlocBuilder<MediaBloc, MediaState>(
                builder: (context, imagesState) {
                  MediaBloc imageBloc = BlocProvider.of(context);
                  deleteFilesLocally(imagesState.deletedFilesIds);
                  if (imagesState.files != null && imagesState.files!.isNotEmpty) {
                    updateFiles(imagesState.files, () {
                      imageBloc.add(const FreeFilesListEvent());
                    });
                  }
                  return Row(
                    children: [
                      GestureDetector(
                          child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(8.5))),
                              child: Image.asset(addImageIconPath, color: kWhite)),
                          onTap: () {
                            if (mediaFiles.length < 11) {
                              ShowResourceTypeBottomSheet().showImageSource(context, (files) {
                                addFilesAction(files);
                                imageBloc.add(UploadMediaEvent(files));
                              }, getFileCount(imageType, mediaFiles), getFileCount(videoType, mediaFiles));
                            } else {
                              Fluttertoast.showToast(
                                  msg: LocaleKeys.youCannotUploadMoreThan11File.tr(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }),
                      Row(
                        children: createListOfImages(mediaFiles, (element) {
                          if (isEdit && mediaFiles.length == 1) {
                            Fluttertoast.showToast(
                                msg: LocaleKeys.oneImageAtLeastIsRequiredMessage.tr(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: pacificBlue,
                                textColor: kWhite);
                          } else {
                            if (isEdit) {
                              //delete file locally only in case of edit
                              deleteFileLocallyAction(element);
                            } else {
                              if (element.id == null) {
                                deleteFileLocallyAction(element);
                              } else {
                                loadingMediaAction(element.path!);
                                imageBloc.add(DeleteMediaEvent(element));
                              }
                            }
                          }
                        }, (element) {
                          loadingMediaAction(element.path!);
                          imageBloc.add(UploadMediaEvent([element]));
                        }, context),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        imageError?.isError ?? false
            ? Container(
                margin: const EdgeInsetsDirectional.only(top: 10, start: 40),
                child: Text(
                  imageError?.errorMessage ?? "",
                  style: errorTextStyle,
                ),
              )
            : Container(),
        if (getFileCount(imageType, mediaFiles) != 0 || getFileCount(videoType, mediaFiles) != 0)
          ImageSectionFooter(
            imageCount: getFileCount(imageType, mediaFiles),
            videoCount: getFileCount(videoType, mediaFiles),
          ),
      ],
    );
  }

  void updateFiles(List<MediaFile>? files, Function freeFilesAction) {
    List<MediaFile> newFilesList = List.empty(growable: true);
    files?.forEach((newFile) {
      for (var oldFile in mediaFiles) {
        if (oldFile.path == newFile.path) {
          newFilesList.add(newFile);
        }
      }
    });
    if (newFilesList.isNotEmpty) {
      addFilesAction(newFilesList);
      freeFilesAction();
    }
  }

  void deleteFilesLocally(Set<int>? deletedFilesIds) {
    for (var element in mediaFiles) {
      if (deletedFilesIds != null && deletedFilesIds.contains(element.id)) {
        deleteFileLocallyAction(element);
      }
    }
  }
}

// bool isAllMediaLoadingAtTheSameTime(List<MediaFile> mediaFiles) {
//   //This check is very important to prevent deleting at least one image in case of uploading others
//   bool isLoading = false;
//   for (var element in mediaFiles) {
//     if (element.status == uploadingLoadingStatus) {
//       isLoading = true;
//     }
//   }
//   return isLoading;
// }