import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sagas_meta/src/blackboard/blackboard.dart';
import 'package:sagas_meta/src/meta/blueprints.pb.dart';

class InteractPanel extends StatefulWidget {
  @override
  State<InteractPanel> createState() => _InteractPanelState();
}

class _InteractPanelState extends State<InteractPanel> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final BlackboardBloc blackboardBloc=BlocProvider.of<BlackboardBloc>(context);

    return Form(
        child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Input',
                hintText: 'i am greet',
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_call),
          onPressed: () {
            // Navigator.pop(context, _textController.text);
            print("fire ...");
            BotMessage body = BotMessage.create()
              ..sender = 'samlet'
              ..message = _textController.text;
            blackboardBloc.dispatch(BotEvent(message: body));

            _textController.clear();
          },
        )
      ],
    ));
  }
}
