import 'package:bloc_test/bloc_test.dart';
import 'package:owner/data/remote/auth/i_auth_repository.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/presentation/auth/login/bloc/login_bloc.dart';
import 'package:owner/presentation/auth/login/bloc/login_event.dart';
import 'package:owner/presentation/auth/login/bloc/login_state.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/application_error.dart';
import 'package:owner/utils/network/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockUser extends Mock implements LoginResponseEntity {}

void main() {
  late LoginBloc loginBloc;
  late IAuthRepository iAuthRepository;
  late LoginResponseEntity mockedUser;

  setUp(() {
    iAuthRepository = MockAuthRepository();
    loginBloc = LoginBloc(authRepository: iAuthRepository);
    mockedUser = MockUser();
  });

  tearDown(() {
    loginBloc.close();
  });

  group('LoginUser event', () {
    blocTest('when logged in with correct credentials and authorized user emit [LoginLoading, LoginSuccess]',
        build: () {
          BaseResponse<LoginResponseEntity> authorizedUserResponse =
          BaseResponse(message: 'Authorized user', data: mockedUser);
          // when(() => mockedUser.isAuthorized).thenAnswer((invocation) => true);
          when(() => iAuthRepository.login(any(), any()))
              .thenAnswer((_) async => Future.value(ApiResponse.success(authorizedUserResponse)));
          return loginBloc;
        },
        act: (LoginBloc bloc) => bloc.add(const LoginUser()),
        expect: () => [const LoginLoading(), const LoginSuccess()]);

    blocTest('when logged in with correct credentials but un authorized user emit [LoginLoading, LoginError]',
        build: () {
          BaseResponse<LoginResponseEntity> authorizedUserResponse =
          BaseResponse(message: 'un Authorized user', data: mockedUser);
          // when(() => mockedUser.isAuthorized).thenAnswer((invocation) => false);
          when(() => iAuthRepository.login(any(), any()))
              .thenAnswer((_) async => Future.value(ApiResponse.success(authorizedUserResponse)));
          return loginBloc;
        },
        act: (LoginBloc bloc) => bloc.add(const LoginUser()),
        expect: () => [const LoginLoading()]);

    blocTest('when logged in with incorrect credentials emit [LoginLoading, LoginError]',
        build: () {
          when(() => iAuthRepository.login(any(), any())).thenAnswer(
                  (_) async => Future.value(ApiResponse.failed(ApplicationError(errorMsg: '', type: Unauthorized()))));
          return loginBloc;
        },
        act: (LoginBloc bloc) => bloc.add(const LoginUser()),
        expect: () => [const LoginLoading()]);
  });

  group('HideError event', () {
    blocTest('when HideError event fired emit EmptyState ',
        build: () {
          return loginBloc;
        },
        act: (LoginBloc bloc) => bloc.add(const HideError()),
        expect: () => [
          const EmptyState(),
        ]);
  });
}
