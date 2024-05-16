import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:twitch_clone/src/feature/bottomnavbar/cubit/bottomnavbar_cubit.dart';
import 'package:twitch_clone/src/injection.dart';
import 'package:twitch_clone/src/routes/route_name.dart';
import 'package:twitch_clone/src/utils/colors.dart';

class Bottomnavbar extends StatefulWidget {
  final Widget child;
  const Bottomnavbar({super.key, required this.child});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BottomnavbarCubit>(),
      child: BlocBuilder<BottomnavbarCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: widget.child,
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: buttonColor,
              unselectedItemColor: primaryColor,
              backgroundColor: backgroundColor,
              unselectedFontSize: 12,
              onTap: (value) {
                onPageChange(value, context);
              },
              currentIndex: state,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Following',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_rounded,
                  ),
                  label: 'Go Live',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.copy,
                  ),
                  label: 'Browse',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void onPageChange(int value, BuildContext context) {
    context.read<BottomnavbarCubit>().onpagechange(value);
    switch (value) {
      case 0:
        context.go(Pagename.homeRoute);
        break;
      case 1:
        context.go(Pagename.goliveRoute);
        break;
    }
  }
}
