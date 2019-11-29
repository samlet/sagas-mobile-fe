import 'package:catalog/forms/editor.dart';
import 'package:catalog/forms/keys.dart';
import 'package:catalog/forms/receiver_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sagas_meta/sagas_bloc.dart';
import 'package:sagas_meta/sagas_meta.dart';

class ReceiverSection extends StatefulWidget {
  final FormRepository formRepository;
  final ReceiverModel receiver;

  ReceiverSection({this.formRepository, this.receiver});

  @override
  State<ReceiverSection> createState() => _ReceiverSectionState();

}

class _ReceiverSectionState extends State<ReceiverSection> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final srvBloc = BlocProvider.of<CommonSrvBloc>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            child: Text(widget.receiver.name.substring(0, 1)),
            // child: Text("客户"),
          ),
        ),
        Expanded(
          //+
            child: GestureDetector(
                onTapUp: (tapDetail) {
                  // selectedIndex = 1;
                  print("press ...");
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                      Editor(
                        formRepository: widget.formRepository,
                        key: ArchSampleKeys.addTodoScreen,
                        onSave: (dc) {
                          srvBloc.dispatch(SimpleEv(message: 'tap modify.'));
                          print('event posted.');
                        },
                        isEditing: false,)));

                  // setState(() {});
                },
                //+
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.receiver.name,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.phone,
                            size: 13.0,
                            color: Color(0xFF929091),
                          ),
                        ),
                        Text(
                          widget.receiver.phoneNumber,
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xFF929091)),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.account_balance,
                              size: 13.0, color: Color(0xFF929091)),
                        ),
                        Text(
                          widget.receiver.accountNumber,
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xFF929091)),
                        ),
                      ],
                    )
                  ],
                )))
      ],
    );
  }
}

