import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
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
import 'bloc/add_camp_first_bloc.dart';
import 'bloc/add_camp_first_event.dart';
import 'bloc/add_camp_first_state.dart';

class AddCampFirstScreen extends StatelessWidget {
  const AddCampFirstScreen({Key? key}) : super(key: key);
  static const tag = "AddCampFirstScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddCampFirstBloc>(
      create: (ctx) => AddCampFirstBloc(UnitRepository()),
      child: BlocBuilder<AddCampFirstBloc, AddCampFirstState>(
        builder: (context, state) {
          AddCampFirstBloc addCampFirstBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              resizeToAvoidBottomInset: true,
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
                            key: AddCampFirstBloc.formKey,
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
                                            width: 60,
                                            height: 60,
                                            alignment: Alignment.center,
                                            child: Image.asset(progress1_4IconPath),
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
                                    controller: addCampFirstBloc.titleEnController,
                                    hintText: LocaleKeys.enterUnitTitle.tr(),
                                    title: LocaleKeys.titleEn.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: addCampFirstBloc.titleEnFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      addCampFirstBloc.titleEnFocus.unfocus();
                                      FocusScope.of(context).requestFocus(addCampFirstBloc.titleArFocus);
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
                                    controller: addCampFirstBloc.titleArController,
                                    hintText: LocaleKeys.enterUnitTitle.tr(),
                                    title: LocaleKeys.titleAr.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: addCampFirstBloc.titleArFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      addCampFirstBloc.titleArFocus.unfocus();
                                      FocusScope.of(context).requestFocus(addCampFirstBloc.descriptionEnFocus);
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
                                    controller: addCampFirstBloc.descriptionEnController,
                                    hintText: LocaleKeys.writeDescription.tr(),
                                    maxLines: 4,
                                    title: LocaleKeys.descriptionEn.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: addCampFirstBloc.descriptionEnFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      addCampFirstBloc.descriptionEnFocus.unfocus();
                                      FocusScope.of(context).requestFocus(addCampFirstBloc.descriptionArFocus);
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
                                    controller: addCampFirstBloc.descriptionArController,
                                    hintText: LocaleKeys.writeDescription.tr(),
                                    maxLines: 4,
                                    title: LocaleKeys.descriptionAr.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: addCampFirstBloc.descriptionArFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      addCampFirstBloc.descriptionArFocus.unfocus();
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
                                    controller: addCampFirstBloc.addressEnController,
                                    hintText: LocaleKeys.enterUnitAddress.tr(),
                                    title: LocaleKeys.addressEn.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: addCampFirstBloc.addressEnFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      addCampFirstBloc.addressEnFocus.unfocus();
                                      FocusScope.of(context).requestFocus(addCampFirstBloc.addressArFocus);
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
                                    controller: addCampFirstBloc.addressArController,
                                    hintText: LocaleKeys.enterUnitAddress.tr(),
                                    title: LocaleKeys.addressAr.tr(),
                                    keyboardType: TextInputType.text,
                                    focusNode: addCampFirstBloc.addressArFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (name) {
                                      addCampFirstBloc.addressArFocus.unfocus();
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
                                  if (AddCampFirstBloc.formKey.currentState?.validate() ?? false) {
                                    addCampFirstBloc.add(const MoveToSecondScreen());
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