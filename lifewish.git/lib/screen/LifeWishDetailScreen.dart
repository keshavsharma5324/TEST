import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_wish/Model/LifeWish.dart' as LifeWishModel;
import 'package:life_wish/Utils/CommonUtils.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/repository/LifeWishRepository.dart';
import 'package:life_wish/screen/MediaControl/ImageViewerScreen.dart';
import 'package:life_wish/screen/MediaControl/VideoPlayerScreen.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/theme/life_wish_icons.dart';

class LifeWishDetailScreen extends StatefulWidget {
  final LifeWishModel.LifeWish lifeWish;

  LifeWishDetailScreen({this.lifeWish});

  @override
  _LifeWishDetailScreenState createState() => _LifeWishDetailScreenState();

  static MaterialPageRoute route(LifeWishModel.LifeWish lifeWish) {
    return MaterialPageRoute(
        builder: (context) => LifeWishDetailScreen(
              lifeWish: lifeWish,
            ));
  }
}

class _LifeWishDetailScreenState extends State<LifeWishDetailScreen> {
  final itemColor = yellow_color;
  final mediaIconSize = 14.0;

  //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _showSnackBar(String msg) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text(msg),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(widget.lifeWish.msgTo),
          centerTitle: true,
          backgroundColor: transparent_color,
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.delete),
              tooltip: 'Delete LifeWish',
              onPressed: _handleDeleteAction,
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
            color: app_bar_bottom_border_color,
            width: 1,
          ),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _wrapWithPadding(
                child: Text(
              widget.lifeWish.subject,
              style: TextStyle(color: yellow_color),
            )),
            _wrapWithPadding(
                child: Row(
              children: [
                Text("Media:"),
                IconButton(
                    iconSize: mediaIconSize,
                    icon: new Icon(
                      LifeWish.attach,
                      color: itemColor,
                    ),
                    onPressed: () {
                      _handleMediaAttachmentClick(SupportedMediaType.audio);
                    }),
                IconButton(
                    iconSize: mediaIconSize,
                    icon: new Icon(
                      LifeWish.camera,
                      color: itemColor,
                    ),
                    onPressed: () {
                      _handleMediaAttachmentClick(SupportedMediaType.image);
                    }),
                IconButton(
                    iconSize: mediaIconSize,
                    icon: new Icon(
                      LifeWish.video,
                      color: itemColor,
                    ),
                    onPressed: () {
                      _handleMediaAttachmentClick(SupportedMediaType.video);
                    })
              ],
            )),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0.3)),
                child: Text(
                  widget.lifeWish.msgBody,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _wrapWithPadding({Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: child,
    );
  }

  _handleMediaAttachmentClick(SupportedMediaType type) async {
    final rootPath = await CommonUtils.generateRootPath();
    String mediaPath;
    switch (type) {
      case SupportedMediaType.video:
        mediaPath = '$rootPath/${widget.lifeWish.ID}/Video';
        final videos = await CommonUtils.getMediaPathsFromDir(mediaPath);
        if (videos.length > 0) {
          Navigator.push(context, VideoPlayerScreen.route(videos.first));
        }

        break;
      case SupportedMediaType.audio:
        mediaPath = '$rootPath/${widget.lifeWish.ID}/Pictures';
        break;
      case SupportedMediaType.image:
        mediaPath = '$rootPath/${widget.lifeWish.ID}/Pictures';
        Navigator.push(context, ImageViewerScreen.route(mediaPath));
        break;
    }
  }

  _handleDeleteAction() async {
    final result =
        await LifeWishRepository().deleteLifeWish(widget.lifeWish.ID);
    if (result == 1) {
      //deleted successfully
      _showSnackBar("Deleted Successfully");
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop(1);
      });
    } else {
      //failed
      _showSnackBar("Failed to delete message. Try after sometime");
    }
  }
}
