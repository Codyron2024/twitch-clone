// import 'package:get_it/get_it.dart';
// import 'package:twitch_clone/src/data/auth/authentication_repository.dart';
// import 'package:twitch_clone/src/feature/authentication/cubit/authentication_cubit.dart';
// final sl = GetIt.I;
// void setupLocator() {
//   sl.registerSingleton<Authenticationrepository>(Authenticationrepository());
//   sl.registerSingleton<AuthenticationCubit>(AuthenticationCubit(auth: sl<Authenticationrepository>()));
// }

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:twitch_clone/src/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
