import 'package:catalog/forms/receiver_model.dart';
import 'package:catalog/forms/send_money_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sagas_meta/sagas_meta.dart';

//import 'shop_items_page.dart';

class DashboardSection {
  final int cellCount;
  final double axisExtent;
  final String type;

  DashboardSection(this.type, this.cellCount, this.axisExtent);
}

/*
    _buildStatsSection(),
    _buildAssetsSection(),
    _buildNotificationSection(),
    _buildChartSection(),
    _buildShopSection()
 */

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

typedef SectionBuilder = Widget Function(DashboardSection sec);

class _DashboardPageState extends State<DashboardPage> {
  final List<DashboardSection> sections = [
    // stats, assets, notification, charts, shop
    DashboardSection("stats", 2, 120.0),
    DashboardSection("assets", 1, 185.0),
    DashboardSection("notification", 1, 185.0),
    DashboardSection("charts", 2, 225.0),
    DashboardSection("shop", 2, 120.0),
  ];

  final List<List<double>> charts =
  [
    [
      0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4
    ],
    [
      0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4,
    ],
    [
      0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4
    ]
  ];

  static final List<String> chartDropdownItems = [
    'Last 7 days', 'Last month', 'Last year'];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;

  //+ repository
  // final BrokerClient brokerClient=new BrokerClient('blue_queue');
  final FormRepository formRepository= new FormRepository(BrokerClient('blue_queue'));

  @override
  Widget build(BuildContext context) {
    final int _kItemCount = sections.length;

    return Scaffold
      (
        appBar: AppBar
          (
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Text('Blueprints', style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 30.0)),
          actions: <Widget>
          [
            Container
              (
              margin: EdgeInsets.only(right: 8.0),
              child: Row
                (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Text('sagas.ai', style: TextStyle(color: Colors.blue,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0)),
                  Icon(Icons.arrow_drop_down, color: Colors.black54)
                ],
              ),
            )
          ],
        ),
        // body: StaggeredGridView.count(
        body: new StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          /*
        children: <Widget>[
          _buildStatsSection(),
          _buildAssetsSection(),
          _buildNotificationSection(),
          _buildChartSection(),
          _buildShopSection()
        ],
        staggeredTiles: [
          // StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 120.0),
          // StaggeredTile.extent(1, 180.0),
          // StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(1, 185.0),
          StaggeredTile.extent(1, 185.0),

          // StaggeredTile.extent(2, 220.0),
          StaggeredTile.extent(2, 225.0),
          // StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 120.0),
        ],
        */
          staggeredTileBuilder: _getTile,
          itemBuilder: _getChild,
          itemCount: _kItemCount,
        )
    );
  }

  StaggeredTile _getTile(int index) {
    final sec = sections[index];
    return StaggeredTile.extent(sec.cellCount, sec.axisExtent);
  }


  Widget _getChild(BuildContext context, int index) {
    final sec = sections[index];
    print("---> $index ${sec.type}");

    SectionBuilder func;
    // stats, assets, notification, charts, shop
    switch (sec.type) {
      case "stats":
        func = _buildStatsSection;
        break;
      case "assets":
        func = _buildAssetsSection;
        break;
      case "notification":
        func = _buildNotificationSection;
        break;
      case "charts":
        func = _buildChartSection;
        break;
      case "shop":
        func = _buildShopSection;
        break;
      default:
        throw new Exception("Cannot build section type ${sec.type}");
        break;
    }
    return func(sec);
  }

  Widget _buildStatsSection(DashboardSection sec) {
    return _buildTile(
      Padding
        (
        padding: const EdgeInsets.all(24.0),
        child: Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>
            [
              Column
                (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Text('Total Views',
                      style: TextStyle(color: Colors.blueAccent)),
                  Text('265K', style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 34.0))
                ],
              ),
              Material
                (
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24.0),
                  child: Center
                    (
                      child: Padding
                        (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                            Icons.timeline, color: Colors.white, size: 30.0),
                      )
                  )
              )
            ]
        ),
      ),
    );
  }

  Widget _buildAssetsSection(DashboardSection sec) {
    return _buildTile(
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column
          (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>
            [
              Material
                (
                  color: Colors.teal,
                  shape: CircleBorder(),
                  child: Padding
                    (
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                        Icons.settings_applications, color: Colors.white,
                        size: 30.0),
                  )
              ),
              Padding(padding: EdgeInsets.only(bottom: 16.0)),
              Text('General', style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0)),
              Text('Images, Videos', style: TextStyle(color: Colors.black45)),
            ]
        ),
      ),
    );
  }

  Widget _buildNotificationSection(DashboardSection sec) {
    return _buildTile(
      Padding
        (
        padding: const EdgeInsets.all(24.0),
        child: Column
          (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>
            [
              Material
                (
                  color: Colors.amber,
                  shape: CircleBorder(),
                  child: Padding
                    (
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                        Icons.notifications, color: Colors.white, size: 30.0),
                  )
              ),
              Padding(padding: EdgeInsets.only(bottom: 16.0)),
              Text('Alerts', style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0)),
              Text('All ', style: TextStyle(color: Colors.black45)),
            ]
        ),
      ),
    );
  }

  Widget _buildChartSection(DashboardSection sec) {
    return _buildTile(
      Padding
        (
          padding: const EdgeInsets.all(24.0),
          child: Column
            (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>
            [
              Row
                (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Column
                    (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text('Revenue', style: TextStyle(color: Colors.green)),
                      Text('\$16K', style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 34.0)),
                    ],
                  ),
                  DropdownButton
                    (
                      isDense: true,
                      value: actualDropdown,
                      onChanged: (String value) =>
                          setState(() {
                            actualDropdown = value;
                            actualChart = chartDropdownItems.indexOf(
                                value); // Refresh the chart
                          }),
                      items: chartDropdownItems.map((String title) {
                        return DropdownMenuItem
                          (
                          value: title,
                          child: Text(title, style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0)),
                        );
                      }).toList()
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 4.0)),
              Sparkline
                (
                data: charts[actualChart],
                lineWidth: 5.0,
                lineColor: Colors.greenAccent,
              )
            ],
          )
      ),
    );
  }

  Widget _buildShopSection(DashboardSection sec) {
    return _buildTile(
      Padding
        (
        padding: const EdgeInsets.all(24.0),
        child: Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>
            [
              Column
                (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Text('Shop Items', style: TextStyle(color: Colors.redAccent)),
                  Text('173', style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 34.0))
                ],
              ),
              Material
                (
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(24.0),
                  child: Center
                    (
                      child: Padding
                        (
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                            Icons.store, color: Colors.white, size: 30.0),
                      )
                  )
              )
            ]
        ),
      ),
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShopItemsPage()))
        print("on tap");
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => SendMoneyPage(formRepository:formRepository, receiver: receivers[0])));
      },
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell
          (
          // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null ? () => onTap() : () {
              print('Not set yet');
            },
            child: child
        )
    );
  }
}
