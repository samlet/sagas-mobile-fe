import 'dart:async';

import 'package:catalog/authentication/authentication_bloc.dart';
import 'package:catalog/forms/date_time_field.dart';
import 'package:catalog/forms/dropdown_field.dart';
import 'package:catalog/forms/form_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TextFieldCreator {
  TextField createTitleTextField(BuildContext context) {
    var fld = new TextField(
      enabled: true,
      decoration: const InputDecoration(
        labelText: 'Event name',
        border: OutlineInputBorder(),
      ),
      style: Theme
          .of(context)
          .textTheme
          .display1,
    );
    return fld;
  }

  TextField createTextField(BuildContext context) {
    return new TextField(
      decoration: const InputDecoration(
        labelText: 'Location',
      ),
      style: Theme
          .of(context)
          .textTheme
          .display1
          .copyWith(fontSize: 20.0),
    );
  }
}
