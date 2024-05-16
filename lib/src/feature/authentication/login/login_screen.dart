import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:twitch_clone/src/feature/authentication/cubit/authentication_cubit.dart';
import 'package:twitch_clone/src/feature/authentication/cubit/authentication_state.dart';
import 'package:twitch_clone/src/injection.dart';
import 'package:twitch_clone/src/routes/route_name.dart';
import 'package:twitch_clone/src/utils/utils.dart';
import 'package:twitch_clone/src/widget/custombutton.dart';
import 'package:twitch_clone/src/widget/customtextfield.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});
  
// tokenn(BuildContext context)async{
//   String? value = await storage.read(key: 'tokenaccess');
//   if (value!.isNotEmpty){
//     context.go(Pagename.homeRoute);
//   }
//    else {
//     context.go(Pagename.loginRoute);
//    }

// }
  @override
  Widget build(BuildContext context) {
    // tokenn(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthenticationCubit>(),
        ),
       
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
              onPressed: () => context.go(Pagename.onboardingRoute),
              color: Colors.black),
          title: const Text(
            'Login',
          ),
        ),
        body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            state.when(
              login: (userload) => null,
              initial: (token) {
              print('weadada$token');
              },
              loading: () => null,
              error: (message) {
                showSnackBar(context, message!);
              },
              success: (userload) {
            
                context.go(Pagename.homeRoute);
              },
            );
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.sp.verticalSpace,
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomTextField(
                          controller: context
                              .read<AuthenticationCubit>()
                              .emailController,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomTextField(
                          controller: context
                              .read<AuthenticationCubit>()
                              .passwordController,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state.maybeWhen(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        orElse: () => CustomButton(
                          onTap: () {
                        context.read<AuthenticationCubit>().loginuser();
                        
                          },
                          text: 'Log In',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
