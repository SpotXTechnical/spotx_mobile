import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/unit_and_action.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'bloc/edit_camp_first_bloc.dart';
import 'bloc/edit_camp_first_event.dart';
import 'bloc/edit_camp_first_state.dart';

class EditCampFirstScreen extends StatelessWidget {
  const EditCampFirstScreen({Key? key}) : super(key: key);
  static const tag = "EditCampFirstScreen";
  @override
  Widget build(BuildContext context) {
    final UnitWithReference unitAndAction = ModalRoute.of(context)!.settings.arguments as UnitWithReference;
    return BlocProvider<EditCampFirstBloc>(
      create: (ctx) => EditCampFirstBloc(UnitRepository())..add(EditFirstGetUnitById(unitAndAction)),
      child: BlocBuilder<EditCampFirstBloc, EditCampFirstState>(
        builder: (context, state) {
          EditCampFirstBloc editCampFirstBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: const Header(
                margin: EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: state.isLoading
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const LoadingWidget(),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Form(
                            key: EditCampFirstBloc.formKey,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.addUnitDetails.tr(),
                                        style: circularBold900(color: kWhite, fontSize: 30),
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            child: Image.asset(progress1_4IconPath, color: kWhite),
                                            width: 60,
                                            height: 60,
                                            alignment: Alignment.center,
                                          ),
                                          Container(
                                            width: 60,
                                            height: 60,
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.ideographic,
                                              children: [
                                                Text("1",
                                                    style: circularBold800(
                                                        color: kWhite, fontSize: 24)),
                                                Text("/4",
                                                    style: circularBold800(
                                                        color: kWhite, fontSize: 14)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                  child: CustomTitledRoundedTextFormWidget(
                                    controller: editCampFirstBloc.titleEnController,
                                    hintText: LocaleKeys.enterUnitTitle.tr(),
                                    title: LocaleKeys.titleEn.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: editCampFirstBloc.titleEnFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      editCampFirstBloc.titleEnFocus.unfocus();
                                      FocusScope.of(context).requestFocus(editCampFirstBloc.titleArFocus);
                                    },
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return LocaleKeys.validationInsertData.tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    autoFocus: true,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                  child: CustomTitledRoundedTextFormWidget(
                                    controller: editCampFirstBloc.titleArController,
                                    hintText: LocaleKeys.enterUnitTitle.tr(),
                                    title: LocaleKeys.titleAr.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: editCampFirstBloc.titleArFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      editCampFirstBloc.titleArFocus.unfocus();
                                      FocusScope.of(context).requestFocus(editCampFirstBloc.descriptionEnFocus);
                                    },
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return LocaleKeys.validationInsertData.tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    autoFocus: true,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                  child: CustomTitledRoundedTextFormWidget(
                                    controller: editCampFirstBloc.descriptionEnController,
                                    hintText: LocaleKeys.writeDescription.tr(),
                                    maxLines: 4,
                                    title: LocaleKeys.descriptionEn.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: editCampFirstBloc.descriptionEnFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      editCampFirstBloc.descriptionEnFocus.unfocus();
                                      FocusScope.of(context).requestFocus(editCampFirstBloc.descriptionArFocus);
                                    },
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return LocaleKeys.validationInsertData.tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    autoFocus: true,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                  child: CustomTitledRoundedTextFormWidget(
                                    controller: editCampFirstBloc.descriptionArController,
                                    hintText: LocaleKeys.writeDescription.tr(),
                                    maxLines: 4,
                                    title: LocaleKeys.descriptionAr.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: editCampFirstBloc.descriptionArFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      editCampFirstBloc.descriptionArFocus.unfocus();
                                    },
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return LocaleKeys.validationInsertData.tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    autoFocus: true,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                  child: CustomTitledRoundedTextFormWidget(
                                    controller: editCampFirstBloc.addressEnController,
                                    hintText: LocaleKeys.enterUnitAddress.tr(),
                                    title: LocaleKeys.addressEn.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: editCampFirstBloc.addressEnFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      editCampFirstBloc.addressEnFocus.unfocus();
                                      FocusScope.of(context).requestFocus(editCampFirstBloc.addressArFocus);
                                    },
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return LocaleKeys.validationInsertData.tr();
                                      } else if (value!.length > 150 || value.length < 5) {
                                        return LocaleKeys.addressInvalidationMessage.tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    autoFocus: true,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                  child: CustomTitledRoundedTextFormWidget(
                                    controller: editCampFirstBloc.addressArController,
                                    hintText: LocaleKeys.enterUnitAddress.tr(),
                                    title: LocaleKeys.addressAr.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: editCampFirstBloc.addressArFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      editCampFirstBloc.addressArFocus.unfocus();
                                    },
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return LocaleKeys.validationInsertData.tr();
                                      } else if (value!.length > 150 || value.length < 5) {
                                        return LocaleKeys.addressInvalidationMessage.tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    autoFocus: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsetsDirectional.only(top: 50, end: 24, start: 24, bottom: 24),
                              child: AppButtonGradient(
                                title: LocaleKeys.next.tr(),
                                height: 55,
                                borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                                textWidget: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(28)),
                                  ),
                                  child: Center(
                                      child: Text(LocaleKeys.next.tr(),
                                          style: circularMedium(color: kWhite, fontSize: 17))),
                                ),
                                action: () async {
                                  if (EditCampFirstBloc.formKey.currentState?.validate() ?? false) {
                                    editCampFirstBloc.add(const EditFirstMoveToSecondScreen());
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> createListOfImages(List<MediaFile>? files) {
    List<Widget> widgetList = List.empty(growable: true);
    files?.forEach((element) async {
      Uint8List? thumbnail;
      if (element.fileType == videoType) {
        thumbnail = await VideoThumbnail.thumbnailData(
          video: element.path!,
          imageFormat: ImageFormat.JPEG,
          maxWidth: 128,
          // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          quality: 25,
        );
      }
      widgetList.add(Container(
          margin: const EdgeInsetsDirectional.only(start: 10),
          width: 72,
          height: 72,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.5)),
            child: element.fileType == imageType
                ? Image.file(
                    File(element.path!),
                    fit: BoxFit.cover,
                  )
                : Image.memory(
                    thumbnail!,
                    fit: BoxFit.cover,
                  ),
          )));
    });
    return widgetList;
  }
}