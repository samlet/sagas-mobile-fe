import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sagas_meta/src/blocs/persist_bloc.dart';
import 'package:sagas_meta/src/data_fetcher.dart';
import 'package:sagas_meta/src/jsonifiers/product_product_jsonifiers.dart';
import 'package:sagas_meta/src/jsonifiers/sagas_dss_jsonifiers.dart';
import 'package:sagas_meta/src/models/product_product.dart';
import 'package:sagas_meta/src/models/sagas_dss.dart';
import 'package:sagas_meta/src/utils.dart';

void main(){
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

  final PersistBloc<ProductType> _entBloc = PersistBloc(
      repository: PersistRepository("ProductType"),
      modifier: (x) => ProductProductJsonifier.overridesProductType(x),
      extractor: (x) => ProductProductJsonifier.extractProductType(x));

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return BlocBuilder(
        bloc: _entBloc,
        builder: (BuildContext context, PersistState state) {
          if (state is PersistEmpty){
            print("❶. fetching ....");
            _entBloc.dispatch(FetchPersist(ids:{'productTypeId':"Test_type_114"}));
            return Center(child: CircularProgressIndicator());
          }
          if (state is PersistLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is PersistLoaded) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, we want to show a Snackbar
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));

                          print("❷. modify .... ${_descriptionController.text}");
                          _entBloc.dispatch(ModifyPersist(vars:{'description':_descriptionController.text}));
                          print("❸. submit ....");
                          // sleep(Duration(seconds: 1));
                          _entBloc.dispatch(SubmitPersist(ids:{'productTypeId':"Test_type_114"}));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            );
          }

          return Text("Hmmm ...");
        });
  }
}
