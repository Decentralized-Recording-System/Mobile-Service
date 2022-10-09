import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/index.dart';
import '../../../repositories/login_repo.dart';
import '../../../services/index.dart';

part 'login_cubit_state.dart';

class LoginCubitCubit extends Cubit<LoginCubitState> {
  LoginCubitCubit({required this.loginRepository})
      : super(const LoginCubitInitial());
  LoginRepository loginRepository = LoginRepository();
  LoginService loginService = LoginService();
  Future<bool> funcLogin(SignIn user) async {
    emit(StateAuthLoading());
    String accessToken = await loginRepository.login(user);
    emit(AccessToken(accessToken: accessToken));
    return loginRepository.getLoginState();
  }

  Future<bool> funcGetLoginState() async {
    return loginRepository.getLoginState();
  }

  Future<bool> funcRegister(SignUp user) async {
    var registerStatus = await loginService.signUp(user);

    return registerStatus;
  }

  void funcGetProfile() async {
    String accessToken = loginRepository.getAccessToken();
    Users userProfile = await loginRepository.getProfile(accessToken);
    emit(StateProfile(userProfile: userProfile));
  }

  void funcLogout() async {
    String accessToken = await loginRepository.logout();
    emit(AccessToken(accessToken: accessToken));
  }

  Future<bool> verifyUserEmail(VerifyEmail user) async {
    var verifyStatus = await loginRepository.requestVerifyEmail(user);
    return verifyStatus;
  }
}
