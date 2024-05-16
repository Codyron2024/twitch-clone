import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:twitch_clone/gen/assets.gen.dart';
import 'package:twitch_clone/src/feature/authentication/cubit/authentication_cubit.dart';
import 'package:twitch_clone/src/feature/authentication/cubit/authentication_state.dart';
import 'package:twitch_clone/src/injection.dart';
import 'package:twitch_clone/src/routes/route_name.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthenticationCubit>()..authchanges(),
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          state.maybeWhen(orElse: (){},login: (userload) {
            if (userload == null ){
                Future.delayed(const Duration(seconds: 3), () {
                  context.go(Pagename.onboardingRoute);
                });
            } else {
                 Future.delayed(const Duration(seconds: 3), () {
                  context.go(Pagename.homeRoute);
                });
            }
          },);
          
        },
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Assets.png.twitchLogo2.image(width: 300.sp),
            const CircularProgressIndicator()],
          ),
        ),
      ),
    );
  }
}
