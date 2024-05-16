import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:twitch_clone/src/data/repository/livestream/livestream_repository.dart';
import 'package:twitch_clone/src/feature/broadcast/cubit/livestream_cubit.dart';
import 'package:twitch_clone/src/feature/broadcast/ui/broadcast_screen.dart';
import 'package:twitch_clone/src/utils/firebase_provider.dart';
import 'package:twitch_clone/src/utils/utils.dart';
import 'package:videosdk/videosdk.dart';

import '../cubit/cubit.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeCubit>()..getallpost(),
        ),
        BlocProvider(
          create: (context) => getIt<LivestreamCubit>(),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Live Users',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Expanded(
                  child: BlocConsumer<HomeCubit, HomeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return state.when(
                        error: (error) => Text(error),
                        initial: () =>
                            const Center(child: CircularProgressIndicator()),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        loaded: (getpost) => getpost.isEmpty
                            ? const Center(child: Text('empty'))
                            : ListView.builder(
                                itemCount: getpost.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                    
                                         
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Broadcastscreen(
                                            meetingId:
                                                getpost[index].meetingid!,
                                            token: token,
                                            mode: Mode.VIEWER,
                                            livedata: getpost[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 120.sp,
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: Image.network(
                                                  getpost[index].image!),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getpost[index].username!,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  getpost[index].title!,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                    '${getpost[index].watching}'),
                                                Text(
                                                  'Started ${timeago.format(DateTime.parse(getpost[index].datecreated.toString()))}',
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.more_vert,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      firebaseauth.signOut();
                    },
                    child: Text('signout')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
