import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:life_wish/Utils/CommonUtils.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/widgets/AnnotatedEditableText.dart';

class MessageComposer extends StatefulWidget {
  final double height;
  final TextEditingController controller;

  MessageComposer({this.height, this.controller});

  @override
  _MessageComposerState createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  bool shouldBoldText = false;
  bool shouldItalicText = false;
  bool shouldUnderlineText = false;
  LifeWishSupportedFont _currentFont;
  Function hp;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _currentFont = CommonUtils.SUPPORTED_FONTS[0];

    _controller = widget.controller ??
        TextEditingController(
            text:
                'Type your message in this box. You can edit your text using given option at the bottom');

    _controller.addListener(() {
      final text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    hp = Screen(MediaQuery.of(context).size).hp;

    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      height: widget.height ?? double.infinity,
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controller,
                  style: TextStyle(
                    fontFamily: _currentFont.name,
                    fontSize: 16,
                    color: currentColor,
                    fontWeight:
                        shouldBoldText ? FontWeight.bold : FontWeight.normal,
                    fontStyle:
                        shouldItalicText ? FontStyle.italic : FontStyle.normal,
                    decoration: shouldUnderlineText
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        AppLocalizations.of(context).translate('discription'),
                  ),
                  maxLines: null,
                ),
              ),
            ),
            Container(
              color: grey_v1,
              height: hp(6),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 8, 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: SizedBox(
                          width: 160,
                          child: Card(
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(4, 4)),
                            ),
                            child: DropdownButton<LifeWishSupportedFont>(
                              // itemHeight: double.infinity,
                              isExpanded: true,
                              value: _currentFont,
                              icon: Icon(Icons.arrow_drop_down),
                              //iconSize: 24,
                              elevation: 16,
                              underline: Container(),
                              onChanged: (LifeWishSupportedFont newValue) {
                                _currentFont = newValue;
                                _reloadWidget();
                              },
                              items: CommonUtils.SUPPORTED_FONTS
                                  .map<DropdownMenuItem<LifeWishSupportedFont>>(
                                      (LifeWishSupportedFont item) {
                                return DropdownMenuItem<LifeWishSupportedFont>(
                                  value: item,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(item.title),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildIconButton(
                      iconData: Icons.format_color_text,
                      onPressed: _showColorPicker,
                    ),
                    buildIconButton(
                      isActive: shouldBoldText,
                      iconData: Icons.format_bold,
                      onPressed: () {
                        shouldBoldText = !shouldBoldText;
                        _reloadWidget();
                      },
                    ),
                    buildIconButton(
                      isActive: shouldItalicText,
                      iconData: Icons.format_italic,
                      onPressed: () {
                        shouldItalicText = !shouldItalicText;
                        _reloadWidget();
                      },
                    ),
                    buildIconButton(
                      isActive: shouldUnderlineText,
                      iconData: Icons.format_underlined,
                      onPressed: () {
                        shouldUnderlineText = !shouldUnderlineText;
                        _reloadWidget();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _reloadWidget() {
    setState(() {});
  }

  Widget buildIconButton({iconData, onPressed, isActive = false}) {
    return Ink(
      decoration: isActive
          ? ShapeDecoration(
              color: isActive ? yellow_color : null,
              shape: CircleBorder(),
            )
          : null,
      child: IconButton(
        //color: isActive ? yellow_color : null,
        splashColor: yellow_color,
        icon: Icon(iconData),
        onPressed: onPressed,
      ),
    );
  }

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  _showColorPicker() {
    // raise the [showDialog] widget
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
          // Use Material color picker:
          //
          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          //   showLabel: true, // only on portrait mode
          // ),
          //
          // Use Block color picker:
          //
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('OK'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
