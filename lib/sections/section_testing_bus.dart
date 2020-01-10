import 'package:catalog/forms/add_edit_screen.dart';
import 'package:catalog/forms/editor.dart';
import 'package:catalog/forms/keys.dart';
import 'package:catalog/forms/receiver_model.dart';
import 'package:catalog/sections/enter_amount_section.dart';
import 'package:catalog/sections/interact_panel.dart';
import 'package:catalog/sections/loc_selection.dart';
import 'package:catalog/sections/receiver_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sagas_meta/sagas_bloc.dart';
import 'package:sagas_meta/sagas_meta.dart';
import 'package:bloc/bloc.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:sagas_meta/src/blackboard/blackboard.dart';
import 'package:sagas_meta/src/message_bus.dart';
import 'package:sagas_meta/src/utils.dart';
import 'package:sagas_meta/src/blackboard/message_indicator_bloc.dart';
import 'package:sagas_meta/src/meta/blueprints.pb.dart';
import 'package:sagas_meta/src/blackboard/responser_bloc.dart';

/**
    Test message bus and blackboard:
    $ python sagas/hybrid/sender.py user.system.hi xxx
 */

class SectionTestingPage extends StatefulWidget {
  final ReceiverModel receiver;
  final FormRepository formRepository;
  final MessageBus messageBus;
  final MessageIndicatorBloc indicatorBloc;

  SectionTestingPage(
      {@required this.formRepository,
      this.receiver,
      @required this.messageBus,
      @required this.indicatorBloc});

  @override
  SectionTestingPageState createState() => SectionTestingPageState();
}

class SectionTestingPageState extends State<SectionTestingPage> {
  int selectedCardIndex = 0;

  BlackboardBloc _blackboardBloc;
  ResponserBloc _responserBloc = ResponserBloc();

  @override
  void initState() {
    super.initState();

    // _client = new Client(settings: settings);
    // _bus=new MessageBus(client: _client);
    var sett=widget.messageBus.client.settings;
    _blackboardBloc = BlackboardBloc(
        messageBus: widget.messageBus,
        // brokerClient: BrokerClient('blue_queue'),
        brokerClient: BrokerClient('blue_queue', client: Client(settings: sett)),
        indicatorBloc: widget.indicatorBloc,
        responserBloc: _responserBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
        blocProviders: [
          BlocProvider<BlackboardBloc>(bloc: _blackboardBloc),
        ],
        child: Scaffold(
          backgroundColor: Color(0xFFF4F4F4),
          body: Center(
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
        ));
  }

  Widget _getSection(int index) {
    switch (index) {
      case 0:
        return _userInfoWidget();
      case 1:
        return _getInteractSection();
      case 2:
        return _submitButton();
      case 3:
        return _responseArea();
    }
  }

  Widget _getInteractSection() {
    return BlocBuilder(
        bloc: _blackboardBloc,
        builder: (_, BlackboardState state) {
          if (state is BlackboardUninitialized) {
            _blackboardBloc.dispatch(LoggedIn(token: 'system'));
            return Center(child: CircularProgressIndicator());
          }
          if (state is BlackboardLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is BlackboardAuthenticated) {
            return Container(
                padding: EdgeInsets.all(16.0), child: InteractPanel());
          }

          return Text("Hmmm ...");
        });
  }

  Widget _userInfoWidget() {
    final indicatorBloc = BlocProvider.of<MessageIndicatorBloc>(context);
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        // child: Row(
        child: BlocBuilder(
            bloc: indicatorBloc,
            builder: (_, ExtractableMessageState state) {
              return Row(
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
                          'Sagas.ai',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  )),
                  Stack(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Icon(
                        Icons.notifications_none,
                        size: 30.0,
                      ),
                    ),
                    new Positioned(
                      // draw a red marble
                      top: 3.0,
                      left: 3.0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFE95482),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            // '02',
                            "${state.posts.length}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                  ]),
                ],
              );
            }));
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        onPressed: () {
          // get input message, and sent it
          /*
          print("submit ...");
          BotMessage body = BotMessage.create()
            ..sender = 'samlet'
            ..message = 'i am greet';
          _blackboardBloc.dispatch(BotEvent(message: body));
          */
          _responserBloc.dispatch(ClearStats());
        },
        child: Text('Clear Responses'),
      ),
    );
  }

  Widget _responseArea() {
    return BlocBuilder(
        bloc: _responserBloc,
        builder: (_, StatsState state) {
          if (state is StatsEmpty) {
            String body = "Say something ...";
            return Container(padding: EdgeInsets.all(16.0), child: Text(body));
          }

          if (state is StatsLoaded) {
            String body = state.items.toString();
            return Container(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(child: Text((body))));
          }

          return Text("Hmmm ...");
        });
  }
}
