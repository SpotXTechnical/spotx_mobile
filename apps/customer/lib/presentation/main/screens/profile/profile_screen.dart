import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/auth/auth_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/bloc/main_bloc.dart';
import 'package:spotx/presentation/main/screens/profile/bloc/profile_bloc.dart';
import 'package:spotx/presentation/main/screens/profile/bloc/profile_event.dart';
import 'package:spotx/presentation/main/screens/profile/bloc/profile_state.dart';
import 'package:spotx/presentation/main/screens/profile/widgets/company_code_widget.dart';
import 'package:spotx/presentation/main/screens/profile/widgets/privacy_terms_widget.dart';
import 'package:spotx/presentation/main/screens/profile/widgets/profile_action_widget.dart';
import 'package:spotx/presentation/main/screens/profile/widgets/profile_basic_info_widget.dart';
import 'package:spotx/presentation/main/screens/profile/widgets/profile_pref_widget.dart';
import 'package:spotx/presentation/main/screens/profile/widgets/success_company_code.dart';
import 'package:spotx/utils/extensions/build_context_extensions.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';

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

  CustomScrollView handleUi(ProfileState state, BuildContext context, ProfileBloc profileBloc, MainBloc mainBloc) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              children: [
                Column(
                  children: [
                    ProfileBasicInfoWidget(
                      getProfileData: () {
                        profileBloc.add(ProfileCheckIfUserIsLoggedInEvent());
                      },
                      user: state.user,
                    ),
                  ],
                ),
                ProfilePrefWidget(
                  user: state.user,
                  reloadProfileScreen: () {
                    profileBloc.add(ProfileCheckIfUserIsLoggedInEvent());
                  },
                ),
                if (state.user != null && state.user?.companyEntity == null)
                  ApplyCompanyCodeWidget(
                    controller: profileBloc.applyCodeController,
                    onApplyPressed: () {
                      FocusScope.of(context).unfocus();
                      profileBloc.add(ApplyCompanyCode());
                    },
                    isLoading: state.isCodeLoading,
                  ),
                if (state.user != null && state.user?.companyEntity != null)
                  const SuccessCompanyCode(),
                const PrivacyTermsWidget(),
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
                      ProfileActionWidget(
                        icon: Image.asset(logoutIconPath, color: kWhite),
                        title: LocaleKeys.logout.tr(),
                        onTap: () {
                          context.showConfirmationAlert(
                            title: LocaleKeys.confirm.tr(),
                            body: LocaleKeys.areYouSureMessage.tr(),
                            confirmButtonTitle: LocaleKeys.confirm.tr(),
                            cancelButtonTitle: LocaleKeys.cancel.tr(),
                            onConfirm: () {
                              profileBloc.add(LogOutUser());
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                    ProfileActionWidget(
                        title: LocaleKeys.deleteAccount.tr(),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onTap: () {
                          context.showConfirmationAlert(
                            title: LocaleKeys.deleteAccount.tr(),
                            body:
                                LocaleKeys.areYouSureMessageDeleteAccount.tr(),
                            confirmButtonTitle: LocaleKeys.yes.tr(),
                            cancelButtonTitle: LocaleKeys.cancel.tr(),
                            onConfirm: () {
                              profileBloc.add(DeleteAccount());
                            },
                          );
                        },
                      ),
                    ],
                )
                : Container(),
          ),
        )
      ],
    );
  }
}