import 'dart:io';

import 'package:flutter/material.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/theme/life_wish_icons.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  VideoPlayerScreen({@required this.videoPath}) : assert(videoPath != null);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();

  static MaterialPageRoute route(String path) {
    return MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
              videoPath: path,
            ));
  }
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;

  @override
  void initState() {
    super.initState();

    _startVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: FlatButton.icon(
            onPressed: () {},
            icon: Icon(
              LifeWish.new_life_wish,
              color: yellow_color,
            ),
            label: Text(
              AppLocalizations.of(context).translate('my_life_wishes'),
              style: TextStyle(fontSize: 18, color: Colors.white),
            )),
        centerTitle: true,
        backgroundColor: transparent_color,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: videoController == null
                    ? Container(
                        color: Colors.yellow,
                      )
                    : AspectRatio(
                        aspectRatio: videoController.value.size != null
                            ? videoController.value.aspectRatio
                            : 1.0,
                        child: VideoPlayer(videoController)),
              ),
            ),
            _captureControlRowWidget(),
          ],
        ),
      ),
    );
  }

  Future<void> _startVideoPlayer() async {
    videoController = VideoPlayerController.file(File(widget.videoPath));

    videoController.addListener(videoPlayerListener);
    await videoController.setLooping(true);
    await videoController.initialize();

    setState(() {});
    await videoController.play();
  }

  Widget _captureControlRowWidget() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.replay_10),
              color: yellow_color,
              onPressed: () {
                videoController.seekTo(Duration(
                    seconds: videoController.value.position.inSeconds - 10));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.play_arrow),
              color: yellow_color,
              onPressed: () {
                if (!videoController.value.isPlaying) {
                  videoController.play();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.pause),
              color: yellow_color,
              onPressed: () {
                if (videoController.value.isPlaying) {
                  videoController.pause();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.forward_10),
              color: yellow_color,
              onPressed: () {
                videoController.seekTo(Duration(
                    seconds: videoController.value.position.inSeconds + 10));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                File(widget.videoPath)
                    .delete()
                    .then((value) => Navigator.pop(context));
              },
            ),
          )
        ],
      ),
    );
  }
}
