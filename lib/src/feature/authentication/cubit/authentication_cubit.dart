import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:twitch_clone/src/data/repository/auth/authentication_repository.dart';
import 'package:twitch_clone/src/data/storage_service.dart';
import 'package:twitch_clone/src/feature/authentication/cubit/authentication_state.dart';
import 'package:twitch_clone/src/utils/firebase_provider.dart';

@injectable
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required this.auth, required this.securestorage})
      : super(const AuthenticationState.initial(null));
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Authenticationrepository auth;
  final Securestorage securestorage;

  loginuser() async {
    emit(const AuthenticationState.loading());
    final res =
        await auth.loginuser(emailController.text, passwordController.text);

    emit(res.fold((l) => AuthenticationState.error(l),
        (r) => AuthenticationState.success(r)));
  }

  authchanges() {
 firebaseauth.userChanges();

    firebaseauth.authStateChanges().listen((User? user) {
      if (user == null) { 
        emit(AuthenticationState.login(user));
      } else {
        emit(AuthenticationState.login(user));
      }
    });
  }

  signup(String email, String password, String username) async {
    emit( const AuthenticationState.loading());
    final res = await auth.signupuser(email, password, username);
  
    res.fold((l) => emit(AuthenticationState.error(l)),
        (r) => emit(AuthenticationState.success(r)));
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    
    return super.close();
  }
}
