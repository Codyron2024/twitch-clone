import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitch_clone/src/data/model/home/live_model.dart';
import 'package:twitch_clone/src/feature/broadcast/ui/broadcastview.dart';
import 'package:twitch_clone/src/feature/broadcast/ui/ils_speaker_view.dart';
import 'package:twitch_clone/src/routes/route_name.dart';
import 'package:videosdk/videosdk.dart';

class Broadcastscreen extends StatefulWidget {
  final String meetingId;
  final String token;
  final Mode mode;
  final Livemodel? livedata;

  const Broadcastscreen(
      {super.key,
      required this.meetingId,
      required this.token,
      required this.mode,
      this.livedata});

  @override
  State<Broadcastscreen> createState() => _BroadcastscreenState();
}

class _BroadcastscreenState extends State<Broadcastscreen> {
  late Room _room;
  bool isJoined = false;

  @override
  void initState() {
    // create room
    _room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      displayName: "John Doe",
      micEnabled: true,
      camEnabled: true,
      defaultCameraIndex:
          1, // Index of MediaDevices will be used to set default camera
      mode: widget.mode,
    );

    setMeetingEventListener();

    // Join room
    _room.join();

    super.initState();
  }

  // listening to meeting events
  void setMeetingEventListener() {
    _room.on(Events.roomJoined, () {
      if (widget.mode == Mode.CONFERENCE) {
        _room.localParticipant.pin();
        print('ronss${_room.hlsUrls}');
      }
      setState(() {
        isJoined = true;
        print(_room.hlsDownstreamUrl);
      });
    });

    _room.on(Events.roomLeft, () {
      context.pushReplacement(Pagename.homeRoute);
      // Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: isJoined
              ? widget.mode == Mode.CONFERENCE
                  ? ILSSpeakerView(
                      room: _room,
                      livedata: widget.livedata?.liveid ?? "",
                    )
                  : widget.mode == Mode.VIEWER
                      ? ILSViewerView(
                          room: _room,
                          livedata: widget.livedata?.liveid ?? "",
                        )
                      : null
              : const Center(
                  child: Text("Joining...",
                      style: TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}
