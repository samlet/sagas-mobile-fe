import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sagas_meta/src/models/sagas_dss.dart';

/// a Spark Bar by hiding both axis, reducing the chart margins.
class DssSparkBar extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DssSparkBar(this.seriesList, {this.animate});

  factory DssSparkBar.withDssData(List<DssOrdinalSales> data) {
    return new DssSparkBar(_createWithDssData(data));
  }

  static List<charts.Series<DssOrdinalSales, String>> _createWithDssData(List<DssOrdinalSales> data) {
    return [
      new charts.Series<DssOrdinalSales, String>(
        id: 'Global Revenue',
        domainFn: (DssOrdinalSales sales, _) => sales.year,
        measureFn: (DssOrdinalSales sales, _) => sales.sales,
        data: data,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,

      /// Assign a custom style for the measure axis.
      ///
      /// The NoneRenderSpec only draws an axis line (and even that can be hidden
      /// with showAxisLine=false).
      primaryMeasureAxis:
          new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),

      /// This is an OrdinalAxisSpec to match up with BarChart's default
      /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
      /// other charts).
      domainAxis: new charts.OrdinalAxisSpec(
          // Make sure that we draw the domain axis line.
          showAxisLine: true,
          // But don't draw anything else.
          renderSpec: new charts.NoneRenderSpec()),

      // With a spark chart we likely don't want large chart margins.
      // 1px is the smallest we can make each margin.
      layoutConfig: new charts.LayoutConfig(
          leftMarginSpec: new charts.MarginSpec.fixedPixel(0),
          topMarginSpec: new charts.MarginSpec.fixedPixel(0),
          rightMarginSpec: new charts.MarginSpec.fixedPixel(0),
          bottomMarginSpec: new charts.MarginSpec.fixedPixel(0)),
    );
  }

}
