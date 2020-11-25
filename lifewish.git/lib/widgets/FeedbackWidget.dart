import 'dart:async';

import 'package:flutter/material.dart';
import 'package:life_wish/Model/response/LoginResponse.dart';

class FeedbackWidget {
  final responseResultFuture;
  final APP_PRIMARY_COLOR = Colors.white;
  final Function onSuccessCallback;
  final String successMsg;
  final String failedMsg;
  final String onProgressMsg;
  BuildContext context;

  FeedbackWidget(
      {this.context,
      this.responseResultFuture,
      this.successMsg,
      this.failedMsg,
      this.onProgressMsg,
      this.onSuccessCallback});

  void showFeedbackBottomSheet() async {
    bool isFormSubmitted = false;
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (BuildContext bc) {
          return FutureBuilder<ApiResponse>(
              future: responseResultFuture,
              builder: (context, snapshot) {
                Widget childWidget = _getProgressViews(snapshot.data);
                if (snapshot.hasData) {
                  final responseMeta = snapshot.data.meta;
                  if (responseMeta?.status == 'FAILED') {
                    childWidget = _getFailedViews(snapshot.data);
                  } else if (responseMeta?.status == "SUCCESS") {
                    childWidget = _getSuccessViews(snapshot.data);
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return childWidget;
              });
        });
  }

  Widget _getProgressViews(ApiResponse data) {
    return Container(
      height: 180,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.info,
              size: 52,
              color: APP_PRIMARY_COLOR,
            ),
          ),
          FittedBox(
            fit: BoxFit.none,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                onProgressMsg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getFailedViews(ApiResponse data) {
    List<Widget> feedBacWidgets = [];
    feedBacWidgets.add(Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Icon(
        Icons.info,
        size: 52,
        color: Colors.red,
      ),
    ));
    feedBacWidgets.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      child: Text(
        failedMsg,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.red),
      ),
    ));
    feedBacWidgets.addAll(data.error
        .map((e) => FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  " ${e.message}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ))
        .toList());

    feedBacWidgets.add(
      Center(
        child: SizedBox(
          width: 120,
          child: OutlineButton(
            borderSide: BorderSide(color: APP_PRIMARY_COLOR),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal)),
          ),
        ),
      ),
    );

    return Container(
      height: 220,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: feedBacWidgets,
      ),
    );
  }

  Widget _getSuccessViews(ApiResponse data) {
    Timer(Duration(seconds: 1), () {
      onSuccessCallback(data);
    });

    return Container(
      height: 200,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.info,
              size: 52,
              color: Colors.green,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                successMsg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 120,
              child: OutlineButton(
                borderSide: BorderSide(color: APP_PRIMARY_COLOR),
                onPressed: () {
                  onSuccessCallback();
                },
                child: Text("Close",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
