import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonUtils {
  static const String LoginStatus = "LoginStatus";
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static setLoginStatus(bool loginStatus) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(LoginStatus, loginStatus).then((bool success) {});
  }

  static const List<LifeWishSupportedFont> SUPPORTED_FONTS = [
    const LifeWishSupportedFont(value: 1, name: "Nunito", title: "Nunito"),
    const LifeWishSupportedFont(value: 2, name: "Roboto", title: "Roboto"),
  ];

  static Future<String> generateRootPath() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    return extDir.path;
  }

  static Future<List<String>> getMediaPathsFromDir(String dir) async {
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
}

enum SupportedMediaType { audio, video, image }

class LifeWishSupportedFont extends Equatable {
  final int value;
  final String name;
  final String title;

  const LifeWishSupportedFont({this.value, this.name, this.title});

  @override
  List<Object> get props => [value, name, title];
}
