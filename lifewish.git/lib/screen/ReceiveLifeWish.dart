import 'package:flutter/material.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/theme/life_wish_icons.dart';

class ReceiveLifeWish extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ReceiveLifeWishState();
  }

}

class ReceiveLifeWishState extends State {
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
                "My LifeWishes",
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
          centerTitle: true,
          backgroundColor: transparent_color,
        ),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(100, (index) {
            return Container(
              margin: EdgeInsets.only(left: 4 ,right: 4 ,top: 4,bottom: 4),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/receive_item_bg.png"),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "SS",
                          style: TextStyle(fontSize: 32 ,fontWeight: FontWeight.bold, color: red_color),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      "23-07-2020",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

}