import 'dart:async';

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

import 'package:sagas_meta/src/blocs/persist_bloc.dart';
import 'package:sagas_meta/src/data_fetcher.dart';
import 'package:sagas_meta/src/jsonifiers/product_product_jsonifiers.dart';
import 'package:sagas_meta/src/jsonifiers/sagas_dss_jsonifiers.dart';
import 'package:sagas_meta/src/models/product_product.dart';
import 'package:sagas_meta/src/models/sagas_dss.dart';
import 'package:sagas_meta/src/utils.dart';

class SectionTestingPage extends StatefulWidget {
  // final ReceiverModel receiver;
  final FormRepository formRepository;

  SectionTestingPage({this.formRepository});

  @override
  SectionTestingPageState createState() => SectionTestingPageState();
}

class SectionTestingPageState extends State<SectionTestingPage> {
  int selectedCardIndex = 0;
  Completer<void> _refreshCompleter;
  PersistBloc<ProductType> _entBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _entBloc = PersistBloc(
        repository: PersistRepository("ProductType"),
        modifier: (x) => ProductProductJsonifier.overridesProductType(x),
        extractor: (x) => ProductProductJsonifier.extractProductType(x));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: BlocBuilder(
            bloc: _entBloc,
            builder: (_, PersistState state) {
              if (state is PersistEmpty) {
                _entBloc.dispatch(
                    FetchPersist(ids: {'productTypeId': "Test_type_114"}));
                return Center(child: CircularProgressIndicator());
              }
              if (state is PersistLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is PersistLoaded) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();

                return RefreshIndicator(
                  onRefresh: () {
                    _entBloc.dispatch(
                      RefreshPersist(ids: {'productTypeId': "Test_type_113"}),
                    );
                    return _refreshCompleter.future;
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 30.0, left: 16.0, right: 16.0),
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
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0),
                              ),
                            ],
                          )),
                      Expanded(
                        child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return _getSection(index, state.data);
                            }),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget _getSection(int index, ProductType pt) {
    switch (index) {
      case 0:
        return _userInfoWidget();

      case 1:
        var rec = ReceiverModel(pt.productTypeId, pt.description ?? "-",
            pt.lastUpdatedStamp.toString());
        return _getReceiverSection(rec);
        break;

    /*case 2:
        return _getCitySection();
      case 3:
        return Container(
            padding: EdgeInsets.all(16.0),
            child: LocationSelection()
        );
        */
    }
  }

  Widget _getReceiverSection(ReceiverModel receiver) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ReceiverSection(
          formRepository: widget.formRepository, receiver: receiver),
    );
  }


  Widget _userInfoWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    child: Text('T'),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'Long Hoang',
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
          Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Icon(Icons.notifications_none,
                    size: 30.0,),
                ),
                new Positioned(  // draw a red marble
                  top: 3.0,
                  left: 3.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFE95482),
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        '02',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                )
              ]
          ),
        ],
      ),
    );
  }
}
