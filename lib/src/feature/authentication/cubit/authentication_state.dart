

import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twitch_clone/src/data/model/user_model.dart';
part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
 const factory AuthenticationState.initial(String? token) = _initial;
 const factory AuthenticationState.loading() = _Loading;
 const factory AuthenticationState.error(String? message) = _Error;
  const factory AuthenticationState.success(UserCredential userload) = _Success;
    const factory AuthenticationState.login(User? userload) = _Login;
    


  
}
