import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'bloc/add_unit_first_bloc.dart';
import 'bloc/add_unit_first_event.dart';
import 'bloc/add_unit_first_state.dart';

class AddUnitFirstScreen extends StatelessWidget {
  const AddUnitFirstScreen({Key? key}) : super(key: key);
  static const tag = "AddUnitFirstScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddUnitFirstBloc>(
      create: (ctx) => AddUnitFirstBloc(UnitRepository())..add(const InitUnit()),
      child: BlocBuilder<AddUnitFirstBloc, AddUnitFirstState>(
        builder: (context, state) {
          AddUnitFirstBloc addUnitFirstBloc = BlocProvider.of(context);
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
                      child: const Center(
                        child: LoadingWidget(),
                      ),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            child: Form(
                              key: AddUnitFirstBloc.formKey,
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
                                      controller: addUnitFirstBloc.titleEnController,
                                      hintText: LocaleKeys.enterUnitTitle.tr(),
                                      title: LocaleKeys.titleEn.tr(),
                                      keyboardType: TextInputType.text,
                                      focusNode: addUnitFirstBloc.titleEnFocus,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (name) {
                                        addUnitFirstBloc.titleEnFocus.unfocus();
                                        FocusScope.of(context).requestFocus(addUnitFirstBloc.titleArFocus);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: CustomTitledRoundedTextFormWidget(
                                      controller: addUnitFirstBloc.titleArController,
                                      hintText: LocaleKeys.enterUnitTitle.tr(),
                                      title: LocaleKeys.titleAr.tr(),
                                      keyboardType: TextInputType.text,
                                      focusNode: addUnitFirstBloc.titleArFocus,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (name) {
                                        addUnitFirstBloc.titleArFocus.unfocus();
                                        FocusScope.of(context).requestFocus(addUnitFirstBloc.descriptionEnFocus);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: CustomTitledRoundedTextFormWidget(
                                      controller: addUnitFirstBloc.descriptionEnController,
                                      hintText: LocaleKeys.writeDescription.tr(),
                                      maxLines: 4,
                                      title: LocaleKeys.descriptionEn.tr(),
                                      keyboardType: TextInputType.multiline,
                                      focusNode: addUnitFirstBloc.descriptionEnFocus,
                                      textInputAction: TextInputAction.newline,
                                      onFieldSubmitted: (name) {
                                        addUnitFirstBloc.descriptionEnFocus.unfocus();
                                        FocusScope.of(context).requestFocus(addUnitFirstBloc.descriptionArFocus);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                                    child: CustomTitledRoundedTextFormWidget(
                                      controller: addUnitFirstBloc.descriptionArController,
                                      hintText: LocaleKeys.writeDescription.tr(),
                                      maxLines: 4,
                                      title: LocaleKeys.descriptionAr.tr(),
                                      keyboardType: TextInputType.multiline,
                                      focusNode: addUnitFirstBloc.descriptionArFocus,
                                      textInputAction: TextInputAction.newline,
                                      onFieldSubmitted: (name) {
                                        addUnitFirstBloc.descriptionArFocus.unfocus();
                                      },
                                    ),
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
                              margin: const EdgeInsetsDirectional.only(end: 24, start: 24, bottom: 24, top: 24),
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
                                  if (AddUnitFirstBloc.formKey.currentState?.validate() ?? false) {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    addUnitFirstBloc.add(const MoveToSecondScreen());
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
}