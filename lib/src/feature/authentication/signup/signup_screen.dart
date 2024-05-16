import 'package:flutter/material.dart';
import 'package:twitch_clone/src/feature/authentication/cubit/authentication_cubit.dart';
import 'package:twitch_clone/src/feature/authentication/cubit/authentication_state.dart';
import 'package:twitch_clone/src/feature/home/cubit/cubit.dart';
import 'package:twitch_clone/src/routes/router.dart';
import 'package:twitch_clone/src/utils/utils.dart';
import 'package:twitch_clone/src/widget/custombutton.dart';
import 'package:twitch_clone/src/widget/customtextfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => getIt<AuthenticationCubit>(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (userload) => context.go(Pagename.loginRoute),
            error: (message) => showSnackBar(context, '$message'),
            orElse: () => null,
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Sign Up',
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(
                        controller: _emailController,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(
                        controller: _usernameController,
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
                        controller: _passwordController,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    state.maybeWhen(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        orElse: () {
                          return CustomButton(
                              onTap: () {
                                context.read<AuthenticationCubit>().signup(
                                    _emailController.text,
                                    _passwordController.text,
                                    _usernameController.text);
                              },
                              text: 'Sign Up');
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
