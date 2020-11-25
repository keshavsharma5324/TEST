import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:life_wish/Model/LifeWish.dart' as LifeWishModel;
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/repository/LifeWishRepository.dart';
import 'package:life_wish/screen/MediaControl/CameraScreen.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/theme/life_wish_icons.dart';
import 'package:life_wish/widgets/MessageComposer.dart';
import 'package:life_wish/widgets/PrimaryButton.dart';

import 'package:uuid/uuid.dart';

import '../Utils/utilwediget.dart';

class NewLifeWishesScreen extends StatefulWidget {
  final lifeWishId;

  NewLifeWishesScreen() : this.lifeWishId = Uuid().v4();

  @override
  State<StatefulWidget> createState() => _NewLifeWishesScreenState();
}

class _NewLifeWishesScreenState extends State<NewLifeWishesScreen> {
  Function wp = null;
  Function hp = null;
  bool _isScheduled = false;
  TextEditingController _subjectController =
      new TextEditingController(text: "");
  TextEditingController _msgBodyController =
      new TextEditingController(text: "");
  TextEditingController _receiverController =
      new TextEditingController(text: "");
  TextEditingController _scheduledDateController =
      new TextEditingController(text: "");

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    wp = Screen(MediaQuery.of(context).size).wp;
    hp = Screen(MediaQuery.of(context).size).hp;
    return WillPopScope(
      onWillPop: _presentConfirmation,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: true,
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                _presentConfirmation();
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
        body: SafeArea(
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 1,
                      color: dark_blue_color,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context).translate('send_to'),
                              style:
                                  TextStyle(fontSize: 18, color: yellow_color),
                            ),
                          ),
                          Flexible(
                            child: Card(
                              elevation: 0.5,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(4, 4)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 4, right: 4),
                                child: TextFormField(
                                  controller: _receiverController,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: new IconButton(
                                        icon:
                                            new Icon(LifeWish.profile_setting),
                                        onPressed: () {}),
                                  ),
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context).translate('subject'),
                              style:
                                  TextStyle(fontSize: 18, color: yellow_color),
                            ),
                          ),
                          Flexible(
                            child: Card(
                              elevation: 0.5,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(4, 4)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 4, right: 4),
                                child: TextFormField(
                                  controller: _subjectController,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: hp(6),
                      padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('schedule_send'),
                              style:
                                  TextStyle(fontSize: 18, color: yellow_color),
                            ),
                          ),
                          Switch(
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey,
                              value: _isScheduled,
                              onChanged: (value) {
                                setState(() {
                                  _isScheduled = value;
                                });
                              })
                        ],
                      ),
                    ),
                    _isScheduled
                        ? Container(
                            padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('send_on'),
                                    style: TextStyle(
                                        fontSize: 18, color: yellow_color),
                                  ),
                                ),
                                Flexible(
                                  child: Card(
                                    elevation: 0.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(4, 4)),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 4, right: 4),
                                      child: TextFormField(
                                        controller: _scheduledDateController,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: new IconButton(
                                              icon: new Icon(LifeWish.calander),
                                              onPressed: () {
                                                _selectDate(context);
                                              }),
                                        ),
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),

                    MessageComposer(
                      height: hp(65) - 155,
                      controller: _msgBodyController,
                    ),
                    //attachments
                    _getAttachmentWidget(),
                    PrimaryButton(
                      width: MediaQuery.of(context).size.width - 16,
                      title: 'send_life_wish',
                      onPressed: () {
                        final item = _getCurrentLifeWish();
                        LifeWishRepository()
                            .insertLifeWish(item)
                            .then((value) => Navigator.of(context).pop(true));
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _getAttachmentWidget() {
    final itemColor = yellow_color;
    return Container(
      height: hp(6),
      padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Attach Media:',
            style: TextStyle(
              color: itemColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          IconButton(
              icon: new Icon(
                LifeWish.attach,
                color: itemColor,
              ),
              onPressed: () {}),
          IconButton(
              icon: new Icon(
                LifeWish.camera,
                color: itemColor,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(CameraScreen.route(widget.lifeWishId));
              }),
          IconButton(
              icon: new Icon(
                LifeWish.video,
                color: itemColor,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(CameraScreen.route(widget.lifeWishId));
              })
        ],
      ),
    );
  }

  Future<bool> _presentConfirmation() {
    return (showMyDialog(
            context: context,
            title: "Alert!!",
            msg: "Do you want to save this message to draft or delete it?",
            actions: <Widget>[
              MaterialButton(
                child: Text(
                  'DISCARD',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  _deleteThisMessage();
                },
              ),
              MaterialButton(
                child: Text(
                  'DRAFT',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  _draftThisMessage();
                },
              ),
              MaterialButton(
                child: Text(
                  'CLOSE',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ])) ??
        false;
  }

  LifeWishModel.LifeWish _getCurrentLifeWish() {
    return LifeWishModel.LifeWish(
        ID: widget.lifeWishId,
        isScheduled: false,
        msgBody: _msgBodyController.value.text,
        msgTo: _receiverController.value.text,
        msgType: 1,
        //SENT
        scheduledTime: DateTime.now().microsecondsSinceEpoch.toString(),
        subject: _subjectController.value.text,
        msgFormatting: "");
  }

  _getMsgFormattingAsString() {}

  _deleteThisMessage() {
    //1. delete message
    //final item = _getCurrentLifeWish();
    //LifeWishRepository().deleteLifeWish(item);
    //2. navigate back
    Navigator.of(context).pop(true);
    Navigator.of(context).pop(true);
  }

  _draftThisMessage() {
    //1. save this message
    final item = _getCurrentLifeWish();
    LifeWishRepository().insertLifeWish(item);

    //2. navigate back
    Navigator.of(context).pop(true);
    Navigator.of(context).pop(true);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _scheduledDateController.text = selectedDate.toLocal().toString();
      });
  }
}
