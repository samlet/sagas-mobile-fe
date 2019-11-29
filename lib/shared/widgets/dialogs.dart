import 'package:catalog/shared/colorful_app.dart';
import 'package:flutter/material.dart';

class RoundedAlertDialog extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget content;

  const RoundedAlertDialog({
    Key key,
    this.title,
    this.actions,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle().copyWith(fontSize: 16.0),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(width: 1.0, color: ColorfulApp.of(context).colors.bleak),
      ),
      content: content,
      actions: actions,
    );
  }
}
