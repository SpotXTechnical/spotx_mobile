import 'package:owner/base/base_bloc.dart';
import 'package:owner/presentation/main/screens/profile/screens/settings/bloc/settings_event.dart';
import 'package:owner/presentation/main/screens/profile/screens/settings/bloc/settings_state.dart';


class SettingsBloc extends BaseBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const InitialSettingsState()) {}
}
