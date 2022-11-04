part of 'login_cubit_cubit.dart';

@immutable
abstract class LoginCubitState {
  const LoginCubitState();

  @override
  List<Object> get props => [];
}

class LoginCubitInitial extends LoginCubitState {
  const LoginCubitInitial();
}

class StateAuthLoading extends LoginCubitState {
  final bool loadingStatus;
  const StateAuthLoading({required this.loadingStatus});

  @override
  List<Object> get props => [loadingStatus];
}

class AccessToken extends LoginCubitState {
  final String accessToken;
  const AccessToken({required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}

class StateProfile extends LoginCubitState {
  final Users userProfile;
  const StateProfile({required this.userProfile});
  @override
  List<Object> get props => [userProfile];
}
