import 'package:catalog/charts/dss_scaffold.dart';
import 'package:catalog/charts/dss_spark_bar.dart';
import 'package:flutter/material.dart';

List<DssScaffold> buildGallery() {
  return [
    new DssScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: 'DSS Spark Bar Chart',
      subtitle: 'DSS Spark Bar Chart',
      childBuilder: (data) => new DssSparkBar.withDssData(data),
    ),
  ];
}
