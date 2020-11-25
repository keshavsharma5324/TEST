import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/theme/life_wish_icons.dart';

class ImageViewerScreen extends StatefulWidget {
  final String imagePaths;
  final fromLocal;
  final borderRadius;

  ImageViewerScreen(
      {@required this.imagePaths,
      this.fromLocal = true,
      this.borderRadius = 8.0})
      : assert(imagePaths != null);

  @override
  _ImageViewerScreenState createState() => _ImageViewerScreenState();

  static MaterialPageRoute route(String path) {
    return MaterialPageRoute(
        builder: (context) => ImageViewerScreen(
              imagePaths: path,
            ));
  }
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  List<Widget> _imagePages;
  int currentPage = 0;
  final _pageController = PageController();
  Future<List<String>> _imageList;

  @override
  void initState() {
    super.initState();
    _imageList = _getImagePathsFromDir(widget.imagePaths);
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
      body: SafeArea(
        child: Container(
          //color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: FutureBuilder<List<String>>(
                future: _imageList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData) {
                    return PageView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _pageController,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return _buildPageForImages(snapshot.data[index]);
                        });
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    //show loader
                    return SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<String>> _getImagePathsFromDir(String dir) async {
    print("path>>dir>> $dir");

    List<String> fileList = List<String>();
    Directory directory = Directory(dir);
    bool dirExit = await directory.exists();
    if (dirExit) {
      directory
          .listSync(recursive: true, followLinks: false)
          .forEach((element) {
        fileList.add(element.path);
        print("path>> ${element.path}");
      });
    }
    return fileList;
  }

  Widget _buildPageForImages(imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      ),
    );

    /*return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: CachedNetworkImage(
        imageUrl: File(imagePath).path,
        placeholder: (context, url) => Center(
          child: Platform.isIOS
              ? CupertinoActivityIndicator()
              : CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );

     */
  }
}
