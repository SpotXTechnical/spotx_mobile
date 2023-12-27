import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/image_entity.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/utils.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_second_screen/bloc/edit_unit_second_state.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:uuid/uuid.dart';
import 'add_room_event.dart';
import 'add_room_state.dart';

class AddRoomBloc extends BaseBloc<AddRoomEvent, AddRoomState> {
  AddRoomBloc(this.unitRepository) : super(const AddRoomState()) {
    on<IncrementRoomNumberEvent>(_incrementRoomNumber);
    on<DecrementRoomNumberEvent>(_decrementRoomNumber);
    on<IncrementBedNumberEvent>(_incrementBedNumber);
    on<DecrementBedNumberEvent>(_decrementBedNumber);
    on<AddRoomAddFilesToList>(_addFilesToFilesList);
    on<AddSpecialPriceRangesEvent>(_addSpecialPriceRanges);
    on<NavigateBack>(_navigateback);
    on<InitRoomEvent>(_initRoom);
    on<DeleteImageLocallyEvent>(_deleteImage);
    on<LoadingMediaEvent>(_loadingMediaEvent);
  }

  final IUnitRepository unitRepository;

  static final formKey = GlobalKey<FormState>();
  static final defaultPriceFromKey = GlobalKey<FormState>();

  final FocusNode titleFocus = FocusNode();
  final FocusNode defaultPriceFocus = FocusNode();
  final FocusNode descriptionArFocus = FocusNode();
  final FocusNode descriptionEnFocus = FocusNode();
  final TextEditingController defaultPriceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionArController = TextEditingController();
  final TextEditingController descriptionEnController = TextEditingController();

  _incrementRoomNumber(IncrementRoomNumberEvent event, Emitter<AddRoomState> emit) {
    var roomNumbers = state.roomNumbers;
    roomNumbers++;
    emit(state.copyWith(roomNumbers: roomNumbers));
  }

  _addSpecialPriceRanges(AddSpecialPriceRangesEvent event, Emitter<AddRoomState> emit) {
    emit(state.copyWith(selectedPriceRanges: event.priceRanges));
  }

  _decrementRoomNumber(DecrementRoomNumberEvent event, Emitter<AddRoomState> emit) {
    var roomNumbers = state.roomNumbers;
    if (state.isEdit) {
      if (roomNumbers <= state.minimumRoomNumber!) {
        roomNumbers--;
        emit(state.copyWith(roomNumbers: roomNumbers));
      } else {
        Fluttertoast.showToast(
            msg: LocaleKeys.youCannotDecreaseRoomNumberMessage.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: kWhite);
      }
    } else {
      roomNumbers--;
      emit(state.copyWith(roomNumbers: roomNumbers));
    }
  }

  _incrementBedNumber(IncrementBedNumberEvent event, Emitter<AddRoomState> emit) {
    var bedNumbers = state.bedNumbers;
    bedNumbers++;
    emit(state.copyWith(bedNumbers: bedNumbers));
  }

  _decrementBedNumber(DecrementBedNumberEvent event, Emitter<AddRoomState> emit) {
    var bedNumbers = state.bedNumbers;
    bedNumbers--;
    emit(state.copyWith(bedNumbers: bedNumbers));
  }

  _initRoom(InitRoomEvent event, Emitter<AddRoomState> emit) async {
    if (event.room != null) {
      titleController.text = event.room!.model!;
      descriptionArController.text = event.room!.descriptionAr ?? "backend empty text";
      descriptionEnController.text = event.room!.descriptionEn ?? "backend empty text";
      defaultPriceController.text = event.room!.defaultPrice ?? "backend empty text";

      List<MediaFile>? files = fromImagesToMediaFiles(event.room!.images);
      if (files != null) {
        for (var element in files) {
          if (element.fileType == videoType && element.path != null) {
            element.thumbnailString = await getVideoThumbnailFromNetwork(element.path);
          }
        }
      }

      emit(state.copyWith(
          roomNumbers: event.room!.count,
          bedNumbers: event.room!.beds,
          selectedPriceRanges: event.room!.priceRanges,
          files: files,
          isEdit: true,
          minimumRoomNumber: event.room!.minRoomNumbers));
    }
  }

  List<MediaFile>? fromImagesToMediaFiles(List<ImageEntity>? images) {
    return images
        ?.map((e) => MediaFile(
              fileType: e.type,
              path: e.path,
              id: e.id,
              status: uploadingSuccessStatus,
            ))
        .toList();
  }

  List<ImageEntity>? fromMediaFilesToImages(List<MediaFile>? mediaFiles) {
    return mediaFiles?.map((e) => ImageEntity(type: e.fileType, path: e.path, unitId: e.id, url: e.path)).toList();
  }

  _deleteImage(DeleteImageLocallyEvent event, Emitter<AddRoomState> emit) {
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    MediaFile? deletedElement;
    deletedElement = newFilesList.firstWhere((element) => element.path == event.file.path);
    newFilesList.removeWhere((element) => element.path == deletedElement!.path);
    emit(state.copyWith(files: newFilesList));
  }

  _loadingMediaEvent(LoadingMediaEvent event, Emitter<AddRoomState> emit) {
    state.files?.firstWhere((element) => element.path == event.path).status = uploadingLoadingStatus;
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    emit(state.copyWith(files: newFilesList));
  }

  _addFilesToFilesList(AddRoomAddFilesToList event, Emitter<AddRoomState> emit) async {
    List<MediaFile> newFilesList = MediaFile.createNewFilesList(state.files);
    List<MediaFile> addedFilesList = List.empty(growable: true);

    //update old files after add image api
    for (var newElement in event.files) {
      for (var oldElement in newFilesList) {
        if (newElement.status != uploadingLoadingStatus) {
          if (newElement.path == oldElement.path) {
            oldElement.id = newElement.id;
            oldElement.status = newElement.status;
          }
        }
      }
    }
    //add new files in case uploading for first time
    addedFilesList.addAll(event.files.where((element) => element.status == uploadingLoadingStatus));
    newFilesList.addAll(addedFilesList);

    for (var element in newFilesList) {
      if (element.fileType == videoType && element.thumbnail == null) {
        element.thumbnail = await getVideoThumbnailFromLocalPath(element);
      }
    }
    emit(state.copyWith(files: newFilesList));
  }

  _navigateback(NavigateBack event, Emitter<AddRoomState> emit) {
    if (state.selectedPriceRanges == null || state.selectedPriceRanges!.isEmpty) {
      emit(state.copyWith(isPriceRangesEmpty: true));
    } else if (state.files == null || state.files!.isEmpty || assertAllImagesAreUploaded(state.files!)) {
      emit(state.copyWith(imageError: getImageErrorMessage(), isPriceRangesEmpty: false));
    } else {
      emit(state.copyWith(
        imageError: ImageError("", isError: false),
      ));
      if (event.room == null) {
        Room room = Room(
            model: titleController.text,
            descriptionAr: descriptionArController.text,
            descriptionEn: descriptionEnController.text,
            count: state.roomNumbers,
            beds: state.bedNumbers,
            defaultPrice: defaultPriceController.text,
            priceRanges: state.selectedPriceRanges,
            imagesIds: state.files!.map((e) => e.id!).toList(),
            images: fromMediaFilesToImages(state.files),
            id: const Uuid().v1());
        navigationKey.currentState?.pop(room);
      } else {
        event.room?.model = titleController.text;
        event.room?.descriptionAr = descriptionArController.text;
        event.room?.descriptionEn = descriptionEnController.text;
        event.room?.count = state.roomNumbers;
        event.room?.beds = state.bedNumbers;
        event.room?.defaultPrice = defaultPriceController.text;
        event.room?.priceRanges = state.selectedPriceRanges;
        event.room?.imagesIds = state.files!.map((e) => e.id!).toList();
        event.room?.images = fromMediaFilesToImages(state.files);
        navigationKey.currentState?.pop(event.room);
      }
    }
  }

  ImageError? getImageErrorMessage() {
    if (state.files == null || state.files!.isEmpty) {
      return ImageError(LocaleKeys.validationInsertData.tr());
    }
    if (assertAllImagesAreUploaded(state.files!)) {
      return ImageError(LocaleKeys.waitUploadingImagesMessage.tr());
    }
    return null;
  }
}