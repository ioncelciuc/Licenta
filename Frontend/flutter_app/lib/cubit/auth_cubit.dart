import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/network/helper/auth_helper.dart';
import 'package:flutter_app/network/response/response.dart';
import 'package:flutter_app/utils/shared_prefs_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  signIn(String username, String password) async {
    emit(AuthLoading());

    Response response = await AuthHelper.signIn(username, password);

    if (response.success) {
      Map<String, dynamic> signInData = response.obj as Map<String, dynamic>;
      String token = signInData['token'];
      await SharedPrefsHelper.instance.setAuthToken(token);
      emit(AuthCompleted());
      return;
    }

    emit(AuthFailed(response));
  }

  signUp(String username, String password) async {
    emit(AuthLoading());

    Response response = await AuthHelper.signUp(username, password);

    log(response.success.toString());
    log(response.message ?? "no message to show to user");

    if (response.success) {
      log('Entered auth completed in sign up cubit implementation');
      emit(AuthCompleted());
      return;
    }

    log('Entered auth failed in sign up cubit implementation');
    emit(AuthFailed(response));
  }
}
