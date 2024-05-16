import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:twitch_clone/src/data/model/home/live_model.dart';
import 'package:twitch_clone/src/feature/broadcast/ui/livestream_player.dart';
import 'package:twitch_clone/src/feature/broadcast/ui/participant_tile.dart';
import 'package:twitch_clone/src/feature/golive/cubit/golive_cubit.dart';
import 'package:twitch_clone/src/feature/home/cubit/cubit.dart';
import 'package:twitch_clone/src/routes/route_name.dart';
import 'package:twitch_clone/src/utils/utils.dart';
import 'package:videosdk/videosdk.dart';

class ILSViewerView extends StatefulWidget {
  final Room room;
  final String? livedata;
  const ILSViewerView({super.key, required this.room, required this.livedata});

  @override
  State<ILSViewerView> createState() => _ILSViewerViewState();
}

class _ILSViewerViewState extends State<ILSViewerView> {
  String hlsState = "HLS_STOPPED";
  String? playbackHlsUrl;
  var micEnabled = true;
  var camEnabled = true;


  Map<String, Participant> participants = {};

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hlsState = widget.room.hlsState;
    playbackHlsUrl = widget.room.hlsDownstreamUrl;
    setMeetingEventListener();
  }



  @override
  Widget build(BuildContext context) {
    
    print('nice$playbackHlsUrl');
    print('nicee$hlsState');
    return Stack(
      children: [
        // ParticipantTile(participant: participants.values.elementAt(0)),s
          playbackHlsUrl != null
              ? LivestreamPlayer(playbackHlsUrl: playbackHlsUrl!)
              : Center(
                child: const Text("Host has not started the Live",
                    style: TextStyle(color: Colors.black)),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  ))
            ],
          ),
        ),
  playbackHlsUrl != null
              ?      Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('message')
                    .doc(widget.livedata)
                    .collection('chat')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final messages = snapshot.data!.docs;
                  return ListView.builder(
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
                                  message['text'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  message['text'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                        .sendmessage(_textEditingController.text, widget.livedata ?? ""),
                  ),
                ],
              ),
            ),
          ],
        ) : SizedBox.fromSize()
      ],
    );
  }

  // listening to meeting events
  void setMeetingEventListener() {
    widget.room.on(
      Events.hlsStateChanged,
      (Map<String, dynamic> data) {
        String status = data['status'];
        log("HLS STATE " + data.toString());
        if (mounted) {
          setState(() {
            hlsState = status;
            if (status == "HLS_PLAYABLE" || status == "HLS_STOPPED") {
              playbackHlsUrl = data['playbackHlsUrl'];
            }
          });
        }
      },
    );
  }
}
