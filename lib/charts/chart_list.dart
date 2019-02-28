import 'dart:developer';

import '../app_config.dart';
import 'package:catalog/charts/drawer.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'bar_gallery.dart' as bar show buildGallery;
import 'dss_gallery.dart' as dss show buildGallery;

class ChartList extends StatelessWidget {
  final bool showPerformanceOverlay;
  final ValueChanged<bool> onShowPerformanceOverlayChanged;
  final barGalleries = bar.buildGallery();
  /*
  final a11yGalleries = a11y.buildGallery();
  final timeSeriesGalleries = time_series.buildGallery();
  final lineGalleries = line.buildGallery();
  final scatterPlotGalleries = scatter_plot.buildGallery();
  final comboGalleries = combo.buildGallery();
  final pieGalleries = pie.buildGallery();
  final axesGalleries = axes.buildGallery();
  final behaviorsGalleries = behaviors.buildGallery();
  final i18nGalleries = i18n.buildGallery();
  final legendsGalleries = legends.buildGallery();
  */

  final dssGalleries = dss.buildGallery();

  ChartList(
      {Key key,
        this.showPerformanceOverlay,
        this.onShowPerformanceOverlayChanged})
      : super(key: key) {
     assert(onShowPerformanceOverlayChanged != null);
  }

  @override
  Widget build(BuildContext context) {
    var galleries = <Widget>[];
    galleries.addAll(
        barGalleries.map((gallery) => gallery.buildGalleryListTile(context)));
    //+ add dss charts
    galleries.addAll(
        dssGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    _setupPerformance();

    return new Scaffold(
      drawer: new GalleryDrawer(
          showPerformanceOverlay: showPerformanceOverlay,
          onShowPerformanceOverlayChanged: onShowPerformanceOverlayChanged),
      appBar: new AppBar(title: new Text(defaultConfig.appName)),
      body: new ListView(padding: kMaterialListPadding, children: galleries),
    );
  }

  void _setupPerformance() {
    // Change [printPerformance] to true and set the app to release mode to
    // print performance numbers to console. By default, Flutter builds in debug
    // mode and this mode is slow. To build in release mode, specify the flag
    // blaze-run flag "--define flutter_build_mode=release".
    // The build target must also be an actual device and not the emulator.
    charts.Performance.time = (String tag) => Timeline.startSync(tag);
    charts.Performance.timeEnd = (_) => Timeline.finishSync();
  }
}
