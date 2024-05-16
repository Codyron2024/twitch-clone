import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:twitch_clone/src/data/model/home/live_model.dart';
import 'package:twitch_clone/src/feature/broadcast/cubit/livestream_cubit.dart';
import 'package:twitch_clone/src/feature/broadcast/ui/meeting_controls.dart';
import 'package:twitch_clone/src/feature/broadcast/ui/participant_tile.dart';
import 'package:twitch_clone/src/feature/golive/cubit/golive_cubit.dart';
import 'package:twitch_clone/src/feature/golive/cubit/golive_state.dart';
import 'package:twitch_clone/src/feature/home/cubit/cubit.dart';
import 'package:twitch_clone/src/routes/route_name.dart';
import 'package:twitch_clone/src/utils/firebase_provider.dart';
import 'package:twitch_clone/src/utils/utils.dart';
import 'package:videosdk/videosdk.dart';

class ILSSpeakerView extends StatefulWidget {
  final Room room;
  final String? livedata;
  const ILSSpeakerView({super.key, required this.room, required this.livedata});

  @override
  State<ILSSpeakerView> createState() => _ILSSpeakerViewState();
}

class _ILSSpeakerViewState extends State<ILSSpeakerView> {
  var micEnabled = true;
  var camEnabled = true;
  String hlsState = "HLS_STOPPED";

  Map<String, Participant> participants = {};

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    if (hlsState == "HLS_STOPPED") {
      widget.room.startHls(config: {
        "layout": {
          "type": "SPOTLIGHT",
          "priority": "PIN",
          "GRID": 20,
        },
        "mode": "video-and-audio",
        "theme": "DARK",
        "quality": "high",
        "orientation": "portrait",
      });
    } else if (hlsState == "HLS_STARTED" || hlsState == "HLS_PLAYABLE") {
      widget.room.stopHls();
    }
    super.initState();
    setMeetingEventListener();
    participants.putIfAbsent(
        widget.room.localParticipant.id, () => widget.room.localParticipant);
    widget.room.participants.values.forEach((participant) {
      if (participant.mode == Mode.CONFERENCE) {
        participants.putIfAbsent(participant.id, () => participant);
      }
    });
    hlsState = widget.room.hlsState;
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  String? liveid;
  liveidfunc() async {
    String? value = await storage.read(key: 'liveid');
    liveid = value;
    print('live$liveid');
  }

  @override
  Widget build(BuildContext context) {
      if (hlsState == "HLS_STOPPED")
                {
                  widget.room.startHls(config: {
                    "layout": {
                      "type": "SPOTLIGHT",
                      "priority": "PIN",
                      "GRID": 20,
                    },
                    "mode": "video-and-audio",
                    "theme": "DARK",
                    "quality": "high",
                    "orientation": "portrait",
                  });
                }
    liveidfunc();
  
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<GoliveCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<LivestreamCubit>()..getlivechat(liveid!),
        ),
      ],
      child: BlocConsumer<GoliveCubit, GoliveState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              ParticipantTile(participant: participants.values.elementAt(0)),
              Column(
                children: [
                  // displaychat(),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('message')
                        .doc(liveid)
                        .collection('chat')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: //${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final messages = snapshot.data!.docs;
                      return Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return ListTile(
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTql7QO1cKJ2vGPissyg8P5dvN0F0fmajfgtEoaIywuRg&s"),
                                    backgroundColor: Colors.transparent,
                                  ),
                                 
                                  10.sp.horizontalSpace,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        message['username'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 20.sp),
                                      ),
                                      Text(
                                        message['text'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                hintText: 'Comment...',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () => context
                              .read<GoliveCubit>()
                              .sendmessage(
                                  _textEditingController.text, liveid!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTql7QO1cKJ2vGPissyg8P5dvN0F0fmajfgtEoaIywuRg&s"),
                      backgroundColor: Colors.transparent,
                    ),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.red),
                        onPressed: () {},
                        child: const Text(
                          'LIVE',
                          style: TextStyle(color: Colors.white),
                        )),
                    5.sp.horizontalSpace,
                    ElevatedButton(
                      onPressed: () {
                        log('wewa');
                        widget.room.leave();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "Leave",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget displaychat() {
    return BlocBuilder<LivestreamCubit, LivestreamState>(
      builder: (context, state) {
        return state.maybeWhen(
          loadchat: (loadchat) {
            return loadchat == null
                ? Text('empty')
                : Expanded(
                    child: Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: loadchat.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTql7QO1cKJ2vGPissyg8P5dvN0F0fmajfgtEoaIywuRg&s"),
                                  backgroundColor: Colors.transparent,
                                ),
                                10.sp.horizontalSpace,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      loadchat[index].username!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      loadchat[index].text!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
          },
          orElse: () => SizedBox.fromSize(),
        );
      },
    );
  }

  // listening to meeting events
  void setMeetingEventListener() {
    widget.room.on(
      Events.participantJoined,
      (Participant participant) {
        if (participant.mode == Mode.CONFERENCE) {
          setState(
            () => participants.putIfAbsent(participant.id, () => participant),
          );
        }
      },
    );

    widget.room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
          () => participants.remove(participantId),
        );
      }
    });
    widget.room.on(
      Events.hlsStateChanged,
      (Map<String, dynamic> data) {
        setState(
          () => hlsState = data['status'],
        );
      },
    );
  }
}
