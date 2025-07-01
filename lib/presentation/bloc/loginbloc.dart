import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quarinom/core/api/apiservice.dart';
import 'package:quarinom/core/models/user.dart'; 

class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginData user;
  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

class LoginEvent {
  final String email;
  final String password;
  final String role;

  LoginEvent(this.email, this.password, this.role);
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;

  LoginBloc(this.apiService) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await apiService.login(event.email, event.password, event.role);
        emit(LoginSuccess(user));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
