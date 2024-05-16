import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:twitch_clone/src/data/repository/livestream/livestream_repository.dart';

import 'package:twitch_clone/src/feature/bottomnavbar/cubit/bottomnavbar_cubit.dart';
import 'package:twitch_clone/src/feature/broadcast/cubit/livestream_cubit.dart';

import 'package:twitch_clone/src/feature/broadcast/ui/broadcast_screen.dart';
import 'package:twitch_clone/src/feature/golive/cubit/golive_cubit.dart';
import 'package:twitch_clone/src/feature/golive/cubit/golive_state.dart';
import 'package:twitch_clone/src/injection.dart';
import 'package:twitch_clone/src/routes/route_name.dart';
import 'package:twitch_clone/src/utils/colors.dart';
import 'package:twitch_clone/src/utils/utils.dart';
import 'package:twitch_clone/src/widget/custombutton.dart';
import 'package:twitch_clone/src/widget/customtextfield.dart';
import 'package:videosdk/videosdk.dart';

class Golivescreen extends StatelessWidget {
  Golivescreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<GoliveCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<LivestreamCubit>(),
        )
      ],
      child: BlocConsumer<LivestreamCubit, LivestreamState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => null,
            error: (errorMessage) async {
              context.go(Pagename.homeRoute);
              await context.read<BottomnavbarCubit>().onpagechange(0);
            },
            success: (issucess) async {
              String? roomid = await storage.read(key: 'roomid');
              print('rooms$roomid');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Broadcastscreen(
                    meetingId: roomid ?? '',
                    token: token,
                    mode: Mode.CONFERENCE,
                  ),
                ),
              );
            },
          );
        },
        builder: (context, state) {
         
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            context.read<LivestreamCubit>().pickfile();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22.0,
                              vertical: 20.0,
                            ),
                            child: state.maybeWhen(
                              imageload: (image) => image != null
                                  ? SizedBox(
                                      height: 300,
                                      child: Image.file(File(image!.path)),
                                    )
                                  : DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10),
                                      dashPattern: const [10, 4],
                                      strokeCap: StrokeCap.round,
                                      color: buttonColor,
                                      child: Container(
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: buttonColor.withOpacity(.05),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.folder_open,
                                              color: buttonColor,
                                              size: 40,
                                            ),
                                            const SizedBox(height: 15),
                                            Text(
                                              'Select your thumbnail',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey.shade400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                              orElse: () => DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                color: buttonColor,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: buttonColor.withOpacity(.05),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        color: buttonColor,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        'Select your thumbnail',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // Handle other states if needed
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Title',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomTextField(
                                controller: titleController,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    state.maybeWhen(
                      loading: () => const CircularProgressIndicator(),
                      imageload: (image) => image != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: CustomButton(
                                text: 'Go Live!',
                                onTap: () async {
                                  context.read<LivestreamCubit>().createmeeting(
                                      titleController.text, 2, image);
                                },
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: CustomButton(
                                text: 'Go Live!',
                                onTap: () {
                                  showSnackBar(context, 'image is required');
                                },
                              ),
                            ),
                      orElse: () {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: CustomButton(
                            text: 'Go Live!',
                            onTap: () {
                              showSnackBar(context, 'Select image is required');
                            },
                          ),
                        );
                      },
                    ),
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
