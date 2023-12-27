import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spotx/data/remote/auth/auth_repository.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/auth/register/widgets/register_input_widget.dart';
import 'package:spotx/presentation/main/screens/profile/screens/edit_profile/bloc/edit_profile_event.dart';
import 'package:spotx/presentation/main/screens/profile/screens/edit_profile/widgets/profile_personal_image.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/header.dart';

import '../../../../../../data/remote/auth/models/login_response_entity.dart';
import '../../../../../auth/register/screens/select_city/select_city_screen.dart';
import 'bloc/edit_profile_bloc.dart';
import 'bloc/edit_profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const tag = "EditProfileScreen";

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    return BlocProvider<EditProfileBloc>(
      create: (ctx) => EditProfileBloc(authRepository: AuthRepository())..add(InitUser(user)),
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          EditProfileBloc editProfileBloc = BlocProvider.of(context);
          return WillPopScope(
            onWillPop: () async {
              if (editProfileBloc.isDataChanged()) {
                showExitWarningDialog(context: context);
              } else {
                navigationKey.currentState?.pop();
              }
              return false;
            },
            child: CustomSafeArea(
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: CustomScaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: Header(
                      onBackAction: () {
                        if (editProfileBloc.isDataChanged()) {
                          showExitWarningDialog(context: context);
                        } else {
                          navigationKey.currentState?.pop();
                        }
                      },
                    ),
                  ),
                  body: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 10),
                          child: Form(
                            key: EditProfileBloc.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.editProfile.tr(),
                                  style: circularBold(color: kWhite, fontSize: 34),
                                ),
                                ProfilePersonalImage(
                                  imageFile: state.image,
                                  networkImage: state.networkImage,
                                  addSingleImage: (image) {
                                    editProfileBloc.add(SetImage(image));
                                  },
                                ),
                                RegisterInputWidget(
                                  controller: editProfileBloc.nameController,
                                  hintText: LocaleKeys.enterYourName.tr(),
                                  title: LocaleKeys.name.tr(),
                                  keyboardType: TextInputType.text,
                                  focusNode: editProfileBloc.nameFocus,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (name) {
                                    editProfileBloc.nameFocus.unfocus();
                                    FocusScope.of(context).requestFocus(editProfileBloc.emailFocus);
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return LocaleKeys.validationInsertData.tr();
                                    } else if (state.errors != null && state.errors?.name != null) {
                                      return state.errors?.name?.first;
                                    } else {
                                      return null;
                                    }
                                  },
                                  autoFocus: true,
                                ),
                                RegisterInputWidget(
                                  controller: editProfileBloc.emailController,
                                  hintText: LocaleKeys.enterYourEmail.tr(),
                                  title: LocaleKeys.email.tr(),
                                  focusNode: editProfileBloc.emailFocus,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (email) {
                                    editProfileBloc.emailFocus.unfocus();
                                    FocusScope.of(context).requestFocus(editProfileBloc.phoneFocus);
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return LocaleKeys.validationInsertData.tr();
                                    } else if (!EmailValidator.validate(value ?? '')) {
                                      return LocaleKeys.emailValidationInsertMsg.tr();
                                    } else if (state.errors != null && state.errors?.email != null) {
                                      return state.errors?.email?.first;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                RegisterInputWidget(
                                  controller: editProfileBloc.phoneController,
                                  hintText: LocaleKeys.enterYourPhoneNumber.tr(),
                                  title: LocaleKeys.phoneNumber.tr(),
                                  keyboardType: TextInputType.number,
                                  focusNode: editProfileBloc.phoneFocus,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (phone) {
                                    editProfileBloc.phoneFocus.unfocus();
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return LocaleKeys.validationInsertData.tr();
                                    } else if (value!.length != 11) {
                                      return LocaleKeys.phoneValidationMessage.tr();
                                    } else if (state.errors != null && state.errors?.phone != null) {
                                      return state.errors?.phone?.first;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsetsDirectional.only(top: 20, start: 24, end: 24, bottom: 15),
                              child: AppButton(
                                title: LocaleKeys.editProfile.tr(),
                                height: 55,
                                borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                                isLoading: state.isLoading,
                                textWidget: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(28)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    LocaleKeys.editProfile.tr(),
                                    style: circularMedium(color: kWhite, fontSize: 17),
                                  )),
                                ),
                                action: () async {
                                  editProfileBloc.add(const HideError());
                                  await Future.delayed(const Duration(milliseconds: 100));
                                  var isFormKeyValid = EditProfileBloc.formKey.currentState?.validate();
                                  if ((isFormKeyValid ?? false)) {
                                    FocusScope.of(context).unfocus();
                                    if (editProfileBloc.isDataChanged()) {
                                      editProfileBloc.add(const UpdateProfile());
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: LocaleKeys.noChangeInDataToUpdateMessage.tr(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: pacificBlue,
                                          textColor: kWhite);
                                    }
                                  } else {
                                    editProfileBloc.add(const HideError());
                                  }
                                },
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void handleNavigationToSelectCityScreen(EditProfileBloc editProfileBloc, BuildContext context) async {
    var result = await navigationKey.currentState?.pushNamed(SelectCityScreen.tag);
    editProfileBloc.add(SetCity(result as City));
    editProfileBloc.phoneFocus.unfocus();
  }
}