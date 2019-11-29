import 'package:catalog/forms/add_edit_screen.dart';
import 'package:catalog/forms/editor.dart';
import 'package:catalog/forms/keys.dart';
import 'package:catalog/forms/receiver_model.dart';
import 'package:catalog/sections/city_selection.dart';
import 'package:catalog/sections/enter_amount_section.dart';
import 'package:catalog/sections/loc_selection.dart';
import 'package:catalog/sections/receiver_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sagas_meta/sagas_bloc.dart';
import 'package:sagas_meta/sagas_meta.dart';

class SectionTestingPage extends StatefulWidget {
  final ReceiverModel receiver;
  final FormRepository formRepository;

  SectionTestingPage({this.formRepository, this.receiver});

  @override
  SectionTestingPageState createState() => SectionTestingPageState();
}

class SectionTestingPageState extends State<SectionTestingPage> {
  int selectedCardIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Text(
                      'Section Testings',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.0),
                    ),
                  ],
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return _getSection(index);
                  }),
            ),
//            _getReceiverSection(this.widget.receiver),
//            _getEnterAmountSection()
          ],
        ),
      ),
    );
  }

  Widget _getSection(int index) {
    switch (index) {
      case 0:
        return _getReceiverSection(widget.receiver);
        break;
      case 1:
        return _getEnterAmountSection();
      case 2:
        return _getCitySection();
      case 3:
        return Container(
            padding: EdgeInsets.all(16.0),
            child: LocationSelection()
        );
    }
  }

  Widget _getCitySection(){
    return Container(
        padding: EdgeInsets.all(16.0),
        child: CitySelection()
    );
  }

  Widget _getReceiverSection(ReceiverModel receiver) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ReceiverSection(formRepository: widget.formRepository, receiver:receiver),
    );
  }

  Widget _getEnterAmountSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: EnterAmountSection(),
    );
  }

}
