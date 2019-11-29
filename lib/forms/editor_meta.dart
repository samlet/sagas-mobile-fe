import 'package:sagas_meta/sagas_meta.dart';

class FieldEditor{
  final String name;
  final String title;
  final MetaFormFieldType fieldType;

  FieldEditor(this.name, this.title, this.fieldType);
}

class FormDataCollector{
  Map<String, dynamic> values={};
}

final List<FieldEditor> sections = [
    FieldEditor("name", "Name", MetaFormFieldType.TEXT),
  ];
