
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sagas_meta/src/blocs/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sagas_meta/src/data_fetcher.dart';
import 'package:sagas_meta/src/jsonifiers/sagas_dss_jsonifiers.dart';
import 'package:sagas_meta/src/models/sagas_dss.dart';

typedef Widget DssWidgetBuilder<T>(List<T> data);

/// Helper to build gallery.
class DssScaffold<T> extends StatefulWidget {
  /// The widget used for leading in a [ListTile].
  final Widget listTileIcon;
  final String title;
  final String subtitle;
  final DssWidgetBuilder<T> childBuilder;

  DssScaffold(
      {this.listTileIcon, this.title, this.subtitle, this.childBuilder});

  /// Gets the gallery
  Widget buildGalleryListTile(BuildContext context) => new ListTile(
      leading: listTileIcon,
      title: new Text(title),
      subtitle: new Text(subtitle),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (_) => this));
      });

  @override
  _DssScaffoldState createState() => new _DssScaffoldState();
}

class _DssScaffoldState extends State<DssScaffold> {
  // final PostBloc _postBloc = PostBloc(httpClient: http.Client());
  final client= http.Client();

  EntityBloc<DssOrdinalSales> _postBloc;

  _DssScaffoldState(){
    final fetcher= new DataFetcher<DssOrdinalSales>(client,
            (jsonData)=> SagasDssJsonifier.extractDssOrdinalSales(jsonData));
    _postBloc = EntityBloc(fetcher: fetcher);
    _postBloc.dispatch(Fetch());
  }

  void _handleButtonPress() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(widget.title)),
      body: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(children: <Widget>[
            new SizedBox(height: 250.0, child: dynamicCreate(context)),
          ])),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.refresh), onPressed: _handleButtonPress),
    );
  }

  Widget dynamicCreate(BuildContext context) {
    return BlocBuilder(
      bloc: _postBloc,
      builder: (BuildContext context, EntityState state) {
        if (state is EntityUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is EntityError) {
          return Center(
            child: Text('failed to fetch entity data'),
          );
        }
        if (state is EntityLoaded<DssOrdinalSales>) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text('no data'),
            );
          }

          return widget.childBuilder(state.posts);
        }
      },
    );
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }

}
