import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/auth/auth_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/bloc/main_bloc.dart';
import 'package:owner/presentation/main/screens/profile/bloc/profile_bloc.dart';
import 'package:owner/presentation/main/screens/profile/bloc/profile_event.dart';
import 'package:owner/presentation/main/screens/profile/bloc/profile_state.dart';
import 'package:owner/presentation/main/screens/profile/widgets/lang_row.dart';
import 'package:owner/presentation/main/screens/profile/widgets/privacy_terms_widget.dart';
import 'package:owner/presentation/main/screens/profile/widgets/profile_basic_info_widget.dart';
import 'package:owner/presentation/main/screens/profile/widgets/profile_option_widget.dart';
import 'package:owner/utils/const.dart';
import 'package:owner/utils/deep_link_utils.dart';
import 'package:owner/utils/extensions/build_context_extensions.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/error_widget.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  static const tag = "ProfileScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (ctx) => ProfileBloc(AuthRepository())..add(ProfileCheckIfUserIsLoggedInEvent()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          ProfileBloc profileBloc = BlocProvider.of(context);
          MainBloc mainBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Header(
                    title: LocaleKeys.profile.tr(),
                    showBackIcon: false,
                  ),
                ),
                body: state.isAuthorized
                    ? state.isProfileLoading
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: const Center(child: LoadingWidget()))
                        : state.isError
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: AppErrorWidget(action: () {
                                  profileBloc.add(ProfileCheckIfUserIsLoggedInEvent());
                                }))
                            : handleUi(state, context, profileBloc, mainBloc)
                    : handleUi(state, context, profileBloc, mainBloc)),
          );
        },
      ),
    );
  }

  CustomScrollView handleUi(
    ProfileState state,
    BuildContext context,
    ProfileBloc profileBloc,
    MainBloc mainBloc,
  ) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              children: [
                ProfileBasicInfoWidget(
                  getProfileData: () {
                    profileBloc.add(ProfileCheckIfUserIsLoggedInEvent());
                  },
                  user: state.user,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileOptionWidget(
                      title:  LocaleKeys.language.tr(),
                      iconPath: langIconPath,
                      onPressed: () {
                        buildBottomSheet(context);
                      },
                    ),
                    const SizedBox(width: 16),
                    ProfileOptionWidget(
                      title:  LocaleKeys.shareProfile.tr(),
                      iconPath: shareIconPath,
                      onPressed: () {
                        createDynamicLink(state.user!.id.toString(),
                            DynamicLinksTargets.owner);
                      },
                    ),
                  ],
                ),
                const PrivacyTermsWidget()
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: state.user != null
                ? Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 19.0, right: 19),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: const BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.all(23),
                              child: Row(
                                children: [
                                  Image.asset(logoutIconPath, color: kWhite),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleKeys.logout.tr(),
                                    style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          context.showConfirmationAlert(
                            title: LocaleKeys.logout.tr(),
                            body: LocaleKeys.areYouSureMessage.tr(),
                            confirmButtonTitle: LocaleKeys.yes.tr(),
                            cancelButtonTitle: LocaleKeys.cancel.tr(),
                            onConfirm: () {
                              profileBloc.add(LogOutUser());
                            },
                          );
                        },
                      ),
                    const SizedBox(height: 16,),
                    InkWell(
                      splashColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 19.0, right: 19),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: const BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.all(23),
                            child: Row(
                              children: [
                                const Icon(Icons.delete, color: Colors.redAccent,),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  LocaleKeys.deleteAccount.tr(),
                                  style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        context.showConfirmationAlert(
                          title: LocaleKeys.deleteAccount.tr(),
                          body: LocaleKeys.areYouSureMessageDeleteAccount.tr(),
                          confirmButtonTitle: LocaleKeys.yes.tr(),
                          cancelButtonTitle: LocaleKeys.cancel.tr(),
                          onConfirm: () {
                            profileBloc.add(DeleteAccount());
                          },
                        );
                      },
                    ),
                  ],
                ) : Container(),
          ),
        )
      ],
    );
  }
}

void buildBottomSheet(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
      ),
      builder: (context) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          margin: const EdgeInsetsDirectional.only(end: 35, start: 35, top: 15, bottom: 10),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext myContext, int index) => LangRow(
              index: index,
              lang: localeList[index],
              selectedLang: context.locale,
            ),
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.transparent,
              );
            },
            itemCount: localeList.length
          )
      )
  );
}