import 'package:flutter/material.dart';
import 'package:life_wish/Model/LifeWish.dart' as Models;
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/repository/LifeWishRepository.dart';
import 'package:life_wish/screen/LifeWishDetailScreen.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/theme/life_wish_icons.dart';

class MyLifeWish extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyLifeWishState();
  }
}

class MyLifeWishState extends State<MyLifeWish> {
  List<Models.LifeWish> _lifeWished;

  @override
  void initState() {
    super.initState();
    _getLifeWishs();
  }

  _getLifeWishs() async {
    _lifeWished = await LifeWishRepository().getAllLifeWish();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Container(
        child: SafeArea(
          child: _lifeWished == null
              ? Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : _lifeWished.length > 0
                  ? GridView.count(
                      crossAxisCount:
                          (MediaQuery.of(context).size.width / 150).round(),
                      shrinkWrap: true,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      //childAspectRatio: 3 / 1,
                      children: List.generate(_lifeWished.length, (index) {
                        final item = _lifeWished[index];
                        return GestureDetector(
                          onTap: () => _handleItemClick(item),
                          child: Container(
                            margin: EdgeInsets.all(4),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/mylifewish_item_bg.png"),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.subject.length > 3
                                            ? item.subject?.substring(0, 3)
                                            : item.subject,
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: yellow_color),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    DateTime.fromMicrosecondsSinceEpoch(
                                            int.parse(item.scheduledTime))
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                  : Center(
                      child: Text(
                        'No LifeWish Yet',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
        ),
      ),
    );
  }

  _handleItemClick(Models.LifeWish item) {
    Navigator.of(context).push(LifeWishDetailScreen.route(item)).then((value) {
      //refresh the page if user has deleted the message
      if (value == 1) {
        _getLifeWishs();
      }
    });
  }
}
