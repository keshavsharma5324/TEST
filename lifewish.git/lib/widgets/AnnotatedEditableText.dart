import 'package:flutter/widgets.dart';

/*
* Uses
AnnotatedEditableText(
controller: _controller,
focusNode: FocusNode(),
style: TextStyle(color: Colors.black),
cursorColor: yellow_color,
selectionColor: yellow_color,
onChanged: (value) {},
onSubmitted: (value) {},
backgroundCursorColor: Colors.white,
annotations: [
Annotation(
    range: TextRange(start: 0, end: 10),
    style: TextStyle(fontSize: 16, color: Colors.red)),
Annotation(
    range: TextRange(start: 19, end: 30),
    style: TextStyle(fontSize: 16, color: Colors.green)),
],
),

*
* */
class Annotation extends Comparable<Annotation> {
  Annotation({@required this.range, this.style});

  final TextRange range;
  final TextStyle style;

  @override
  int compareTo(Annotation other) {
    return range.start.compareTo(other.range.start);
  }

  @override
  String toString() {
    return 'Annotation(range:$range, style:$style)';
  }
}

class AnnotatedEditableText extends EditableText {
  AnnotatedEditableText({
    Key key,
    FocusNode focusNode,
    TextEditingController controller,
    TextStyle style,
    ValueChanged<String> onChanged,
    ValueChanged<String> onSubmitted,
    Color cursorColor,
    Color selectionColor,
    TextSelectionControls selectionControls,
    Color backgroundCursorColor,
    this.annotations,
  }) : super(
            key: key,
            focusNode: focusNode,
            controller: controller,
            cursorColor: cursorColor,
            style: style,
            keyboardType: TextInputType.text,
            autocorrect: true,
            autofocus: true,
            selectionColor: selectionColor,
            selectionControls: selectionControls,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            backgroundCursorColor: backgroundCursorColor);

  final List<Annotation> annotations;

  @override
  AnnotatedEditableTextState createState() => new AnnotatedEditableTextState();
}

class AnnotatedEditableTextState extends EditableTextState {
  @override
  AnnotatedEditableText get widget => super.widget;

  List<Annotation> getRanges() {
    var source = widget.annotations;
    source.sort();
    var result = new List<Annotation>();
    Annotation prev;
    for (var item in source) {
      if (prev == null) {
        // First item, check if we need one before it.
        if (item.range.start > 0) {
          result.add(new Annotation(
            range: TextRange(start: 0, end: item.range.start),
          ));
        }
        result.add(item);
        prev = item;
        continue;
      } else {
        // Consequent item, check if there is a gap between.
        if (prev.range.end > item.range.start) {
          // Invalid ranges
          throw new StateError(
              'Invalid (intersecting) ranges for annotated field');
        } else if (prev.range.end < item.range.start) {
          result.add(Annotation(
            range: TextRange(start: prev.range.end, end: item.range.start),
          ));
        }
        // Also add current annotation
        result.add(item);
        prev = item;
      }
    }
    // Also check for trailing range
    final String text = textEditingValue.text;
    if (result.last.range.end < text.length) {
      result.add(Annotation(
        range: TextRange(start: result.last.range.end, end: text.length),
      ));
    }
    return result;
  }

  @override
  TextSpan buildTextSpan() {
    final String text = textEditingValue.text;
    if (widget.annotations != null) {
      var items = getRanges();
      var children = <TextSpan>[];
      for (var item in items) {
        children.add(
          TextSpan(style: item.style, text: item.range.textInside(text)),
        );
      }
      return new TextSpan(style: widget.style, children: children);
    }

    return new TextSpan(style: widget.style, text: text);
  }
}
