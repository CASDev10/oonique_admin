import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/ui/widgets/helper_function.dart';

import '../../../../core/exceptions/api_error.dart';
import '../../../../utils/logger/logger.dart';
import '../../models/authResponse.dart';
import '../../models/login_input_model.dart';
import '../../repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(LoginState.initial());

  final _log = logger(LoginCubit);

  void toggleShowPassword() => emit(
    state.copyWith(
      isPasswordHidden: !state.isPasswordHidden,
      loginStatus: LoginStatus.initial,
    ),
  );

  void toggleShowConfirmPassword() => emit(
    state.copyWith(
      isConfirmPasswordHidden: !state.isConfirmPasswordHidden,
      loginStatus: LoginStatus.initial,
    ),
  );

  void enableAutoValidateMode() => emit(
    state.copyWith(isAutoValidate: true, loginStatus: LoginStatus.initial),
  );

  Future<void> login(LoginInput loginInput) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));

    try {
      // loginInput.fcmToken = await sl<CloudMessagingApi>().getFcmToken() ?? '';
      // _log.e('fcm token is :: ${loginInput.fcmToken}');
      // print('fcm token is :: ${loginInput.fcmToken}');
      AuthResponse authResponse = await _authRepository.login(loginInput);
      if (authResponse.result == 'success') {
        await setToken(authResponse.data.token);
        emit(state.copyWith(loginStatus: LoginStatus.success));
      } else {
        emit(
          state.copyWith(
            loginStatus: LoginStatus.error,
            errorMessage: authResponse.message,
          ),
        );
      }
    } on ApiError catch (e) {
      emit(
        state.copyWith(loginStatus: LoginStatus.error, errorMessage: e.message),
      );
    }
  }
}
