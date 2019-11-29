// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:catalog/forms/form_common.dart';
import 'package:catalog/panels/chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//import '../../gallery/demo.dart';

class Dessert {
  Dessert(this.name, this.calories, this.fat, this.carbs, this.protein,
      this.sodium, this.calcium, this.iron);

  final String name;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  final int sodium;
  final int calcium;
  final int iron;

  bool selected = false;
}

class DessertDataSource extends DataTableSource {
  final List<Dessert> _desserts = <Dessert>[
    Dessert('Frozen yogurt', 159, 6.0, 24, 4.0, 87, 14, 1),
    Dessert('Ice cream sandwich', 237, 9.0, 37, 4.3, 129, 8, 1),
    Dessert('Eclair', 262, 16.0, 24, 6.0, 337, 6, 7),
    Dessert('Cupcake', 305, 3.7, 67, 4.3, 413, 3, 8),
    Dessert('Gingerbread', 356, 16.0, 49, 3.9, 327, 7, 16),
    Dessert('Jelly bean', 375, 0.0, 94, 0.0, 50, 0, 0),
    Dessert('Lollipop', 392, 0.2, 98, 0.0, 38, 0, 2),
    Dessert('Honeycomb', 408, 3.2, 87, 6.5, 562, 0, 45),
    Dessert('Donut', 452, 25.0, 51, 4.9, 326, 2, 22),
    Dessert('KitKat', 518, 26.0, 65, 7.0, 54, 12, 6),
    Dessert('Frozen yogurt with sugar', 168, 6.0, 26, 4.0, 87, 14, 1),
    Dessert('Ice cream sandwich with sugar', 246, 9.0, 39, 4.3, 129, 8, 1),
    Dessert('Eclair with sugar', 271, 16.0, 26, 6.0, 337, 6, 7),
    Dessert('Cupcake with sugar', 314, 3.7, 69, 4.3, 413, 3, 8),
    Dessert('Gingerbread with sugar', 345, 16.0, 51, 3.9, 327, 7, 16),
    Dessert('Jelly bean with sugar', 364, 0.0, 96, 0.0, 50, 0, 0),
    Dessert('Lollipop with sugar', 401, 0.2, 100, 0.0, 38, 0, 2),
    Dessert('Honeycomb with sugar', 417, 3.2, 89, 6.5, 562, 0, 45),
    Dessert('Donut with sugar', 461, 25.0, 53, 4.9, 326, 2, 22),
    Dessert('KitKat with sugar', 527, 26.0, 67, 7.0, 54, 12, 6),
    Dessert('Frozen yogurt with honey', 223, 6.0, 36, 4.0, 87, 14, 1),
    Dessert('Ice cream sandwich with honey', 301, 9.0, 49, 4.3, 129, 8, 1),
    Dessert('Eclair with honey', 326, 16.0, 36, 6.0, 337, 6, 7),
    Dessert('Cupcake with honey', 369, 3.7, 79, 4.3, 413, 3, 8),
    Dessert('Gingerbread with honey', 420, 16.0, 61, 3.9, 327, 7, 16),
    Dessert('Jelly bean with honey', 439, 0.0, 106, 0.0, 50, 0, 0),
    Dessert('Lollipop with honey', 456, 0.2, 110, 0.0, 38, 0, 2),
    Dessert('Honeycomb with honey', 472, 3.2, 99, 6.5, 562, 0, 45),
    Dessert('Donut with honey', 516, 25.0, 63, 4.9, 326, 2, 22),
    Dessert('KitKat with honey', 582, 26.0, 77, 7.0, 54, 12, 6),
    Dessert('Frozen yogurt with milk', 262, 8.4, 36, 12.0, 194, 44, 1),
    Dessert('Ice cream sandwich with milk', 339, 11.4, 49, 12.3, 236, 38, 1),
    Dessert('Eclair with milk', 365, 18.4, 36, 14.0, 444, 36, 7),
    Dessert('Cupcake with milk', 408, 6.1, 79, 12.3, 520, 33, 8),
    Dessert('Gingerbread with milk', 459, 18.4, 61, 11.9, 434, 37, 16),
    Dessert('Jelly bean with milk', 478, 2.4, 106, 8.0, 157, 30, 0),
    Dessert('Lollipop with milk', 495, 2.6, 110, 8.0, 145, 30, 2),
    Dessert('Honeycomb with milk', 511, 5.6, 99, 14.5, 669, 30, 45),
    Dessert('Donut with milk', 555, 27.4, 63, 12.9, 433, 32, 22),
    Dessert('KitKat with milk', 621, 28.4, 77, 15.0, 161, 42, 6),
    Dessert('Coconut slice and frozen yogurt', 318, 21.0, 31, 5.5, 96, 14, 7),
    Dessert(
        'Coconut slice and ice cream sandwich', 396, 24.0, 44, 5.8, 138, 8, 7),
    Dessert('Coconut slice and eclair', 421, 31.0, 31, 7.5, 346, 6, 13),
    Dessert('Coconut slice and cupcake', 464, 18.7, 74, 5.8, 422, 3, 14),
    Dessert('Coconut slice and gingerbread', 515, 31.0, 56, 5.4, 316, 7, 22),
    Dessert('Coconut slice and jelly bean', 534, 15.0, 101, 1.5, 59, 0, 6),
    Dessert('Coconut slice and lollipop', 551, 15.2, 105, 1.5, 47, 0, 8),
    Dessert('Coconut slice and honeycomb', 567, 18.2, 94, 8.0, 571, 0, 51),
    Dessert('Coconut slice and donut', 611, 40.0, 58, 6.4, 335, 2, 28),
    Dessert('Coconut slice and KitKat', 677, 41.0, 72, 8.5, 63, 12, 12),
  ];

  void _sort<T>(Comparable<T> getField(Dessert d), bool ascending) {
    _desserts.sort((Dessert a, Dessert b) {
      if (!ascending) {
        final Dessert c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _desserts.length) return null;
    final Dessert dessert = _desserts[index];
    return DataRow.byIndex(
        index: index,
        selected: dessert.selected,
        onSelectChanged: (bool value) {
          if (dessert.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            dessert.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text('${dessert.name}')),
          DataCell(Text('${dessert.calories}')),
          DataCell(Text('${dessert.fat.toStringAsFixed(1)}')),
          DataCell(Text('${dessert.carbs}')),
          DataCell(Text('${dessert.protein.toStringAsFixed(1)}')),
          DataCell(Text('${dessert.sodium}')),
          DataCell(Text('${dessert.calcium}%')),
          DataCell(Text('${dessert.iron}%')),
        ]);
  }

  @override
  int get rowCount => _desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (Dessert dessert in _desserts) dessert.selected = checked;
    _selectedCount = checked ? _desserts.length : 0;
    notifyListeners();
  }
}

class DataTableDemo extends StatefulWidget {
  static const String routeName = '/material/data-table';

  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  final DessertDataSource _dessertsDataSource = DessertDataSource();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
  }

  void _sort<T>(
      Comparable<T> getField(Dessert d), int columnIndex, bool ascending) {
    _dessertsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void _showMessage() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('You tapped the floating action button.'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        );
      },
    );
  }

  void _showModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => const _DemoDrawer(),
    );
  }

  void _showBottomSheet() {
    setState(() {
      // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<void>((BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          /*
          return Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: themeData.disabledColor))),
              child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                      'This is a Material persistent bottom sheet. Drag downwards to dismiss it.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: themeData.accentColor, fontSize: 24.0))));
          */
          // return _DemoDrawer();
          return InteractInput();
          // return _DemoPrompt();
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              // re-enable the button
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Data tables'),
          actions: <Widget>[
            MaterialDemoDocumentationButton(DataTableDemo.routeName),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          // onPressed: _showMessage,
          onPressed: _showBottomSheetCallback,
          // onPressed: _showModal,
          backgroundColor: Colors.redAccent,
          child: const Icon(
            Icons.message,
            semanticLabel: 'Add',
          ),
        ),
        body: ListView(padding: const EdgeInsets.all(20.0), children: <Widget>[
          PaginatedDataTable(
              header: const Text('Nutrition'),
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (int value) {
                setState(() {
                  _rowsPerPage = value;
                });
              },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              onSelectAll: _dessertsDataSource._selectAll,
              columns: <DataColumn>[
                DataColumn(
                    label: const Text('Dessert (100g serving)'),
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Dessert d) => d.name, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Calories'),
                    tooltip:
                        'The total amount of food energy in the given serving size.',
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Dessert d) => d.calories, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Fat (g)'),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Dessert d) => d.fat, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Carbs (g)'),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Dessert d) => d.carbs, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Protein (g)'),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Dessert d) => d.protein, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Sodium (mg)'),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Dessert d) => d.sodium, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Calcium (%)'),
                    tooltip:
                        'The amount of calcium as a percentage of the recommended daily amount.',
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Dessert d) => d.calcium, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Iron (%)'),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Dessert d) => d.iron, columnIndex, ascending)),
              ],
              source: _dessertsDataSource)
        ]));
  }
}

// ------------------------------------------------------------------------
// A drawer that pops up from the bottom of the screen.
class _DemoDrawer extends StatelessWidget {
  const _DemoDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
          ),
          ListTile(
            leading: Icon(Icons.threed_rotation),
            title: Text('3D'),
          ),
        ],
      ),
    );
  }
}

class _DemoPrompt extends StatelessWidget {
  const _DemoPrompt();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: themeData.disabledColor))),
        child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
                'This is a Material persistent bottom sheet. Drag downwards to dismiss it.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: themeData.accentColor, fontSize: 24.0))));
  }
}

class InteractInput extends StatefulWidget {
  const InteractInput();

  @override
  _InteractInputState createState() => _InteractInputState();
}

const List<String> _defaultMaterials = <String>[
  'poker',
  'tortilla',
  'fish and',
  'micro',
  'wood',
];

const List<String> _defaultActions = <String>[
  'flake',
  'cut',
  'fragment',
  'splinter',
  'nick',
  'fry',
  'solder',
  'cash in',
  'eat',
];

const Map<String, String> _results = <String, String>{
  'flake': 'flaking',
  'cut': 'cutting',
  'fragment': 'fragmenting',
  'splinter': 'splintering',
  'nick': 'nicking',
  'fry': 'frying',
  'solder': 'soldering',
  'cash in': 'cashing in',
  'eat': 'eating',
};

const List<String> _defaultTools = <String>[
  'hammer',
  'chisel',
  'fryer',
  'fabricator',
  'customer',
];

const Map<String, String> _avatars = <String, String>{
  'hammer': 'people/square/ali.png',
  'chisel': 'people/square/sandra.png',
  'fryer': 'people/square/trevor.png',
  'fabricator': 'people/square/stella.png',
  'customer': 'people/square/peter.png',
};

final Map<String, Set<String>> _toolActions = <String, Set<String>>{
  'hammer': Set<String>()..addAll(<String>['flake', 'fragment', 'splinter']),
  'chisel': Set<String>()..addAll(<String>['flake', 'nick', 'splinter']),
  'fryer': Set<String>()..addAll(<String>['fry']),
  'fabricator': Set<String>()..addAll(<String>['solder']),
  'customer': Set<String>()..addAll(<String>['cash in', 'eat']),
};

final Map<String, Set<String>> _materialActions = <String, Set<String>>{
  'poker': Set<String>()..addAll(<String>['cash in']),
  'tortilla': Set<String>()..addAll(<String>['fry', 'eat']),
  'fish and': Set<String>()..addAll(<String>['fry', 'eat']),
  'micro': Set<String>()..addAll(<String>['solder', 'fragment']),
  'wood': Set<String>()..addAll(<String>['flake', 'cut', 'splinter', 'nick']),
};

class _InteractInputState extends State<InteractInput> {
  final TextEditingController messageController = TextEditingController();

  // ....
  final Set<String> _materials = Set<String>();
  String _selectedMaterial = '';
  String _selectedAction = '';
  final Set<String> _tools = Set<String>();
  final Set<String> _selectedTools = Set<String>();
  final Set<String> _actions = Set<String>();
  bool _showShapeBorder = false;

  // Initialize members with the default data.
  void _reset() {
    _materials.clear();
    _materials.addAll(_defaultMaterials);
    _actions.clear();
    _actions.addAll(_defaultActions);
    _tools.clear();
    _tools.addAll(_defaultTools);
    _selectedMaterial = '';
    _selectedAction = '';
    _selectedTools.clear();
  }

  void _removeMaterial(String name) {
    _materials.remove(name);
    if (_selectedMaterial == name) {
      _selectedMaterial = '';
    }
  }

  void _removeTool(String name) {
    _tools.remove(name);
    _selectedTools.remove(name);
  }

  String _capitalize(String name) {
    assert(name != null && name.isNotEmpty);
    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }

  // This converts a String to a unique color, based on the hash value of the
  // String object.  It takes the bottom 16 bits of the hash, and uses that to
  // pick a hue for an HSV color, and then creates the color (with a preset
  // saturation and value).  This means that any unique strings will also have
  // unique colors, but they'll all be readable, since they have the same
  // saturation and value.
  Color _nameToColor(String name) {
    assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  AssetImage _nameToAvatar(String name) {
    assert(_avatars.containsKey(name));
    return AssetImage(
      _avatars[name],
      package: 'flutter_gallery_assets',
    );
  }

  String _createResult() {
    if (_selectedAction.isEmpty) {
      return '';
    }
    return _capitalize(_results[_selectedAction]) + '!';
  }

  _InteractInputState() {
    _reset();
  }

  Widget _getEnterSection() {
    final List<Widget> chips = _materials.map<Widget>((String name) {
      return Chip(
        key: ValueKey<String>(name),
        backgroundColor: _nameToColor(name),
        label: Text(_capitalize(name)),
        onDeleted: () {
          setState(() {
            _removeMaterial(name);
          });
        },
      );
    }).toList();
    final List<Widget> filterChips = _defaultTools.map<Widget>((String name) {
      return FilterChip(
        key: ValueKey<String>(name),
        label: Text(_capitalize(name)),
        selected: _tools.contains(name) ? _selectedTools.contains(name) : false,
        onSelected: !_tools.contains(name)
            ? null
            : (bool value) {
                setState(() {
                  if (!value) {
                    _selectedTools.remove(name);
                  } else {
                    _selectedTools.add(name);
                  }
                });
              },
      );
    }).toList();

    final ThemeData theme = Theme.of(context);
    final List<Widget> tiles = <Widget>[
      const SizedBox(height: 8.0, width: 0.0),
      ChipsTile(label: 'Available Materials (Chip)', children: chips),
      // ChipsTile(label: 'Choose Tools (FilterChip)', children: filterChips),
      /*
      const Divider(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            _createResult(),
            style: theme.textTheme.title,
          ),
        ),
      ),
      */
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Text(
                  'Input a message',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '\@',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: messageController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          decoration: InputDecoration(
                              hintText: 'i am great',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              /*-
              Padding(
                padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                // child: ListView(children: tiles),
                child: Row(
                    children: <Widget>[
                      Expanded(
                    child: ListView(children: tiles))]),
              ),
              */
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 0.0),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: <Widget>[
                    Chip(
                      key: ValueKey<String>('hello'),
                      label: Text(_capitalize('hello')),
                      onDeleted: () {
                        setState(() {
                          _removeMaterial('hello');
                        });
                      },
                    ),
                    Chip(
                      key: ValueKey<String>('great'),
                      label: Text(_capitalize("i am greet")),
                      onDeleted: () {
                        setState(() {
                          _removeMaterial('great');
                        });
                      },
                    ),
                    Chip(
                      key: ValueKey<String>('bad'),
                      label: Text(_capitalize("i am bad")),
                      onDeleted: () {
                        setState(() {
                          _removeMaterial('bad');
                        });
                      },
                    ),
                    Chip(
                      key: ValueKey<String>('descrip'),
                      label: Text(_capitalize(
                          "We are taking one example in which, we will add a button and a card. ")),
                      onDeleted: () {
                        setState(() {
                          _removeMaterial('descrip');
                        });
                      },
                    ),
                  ]))),

              // other group chips [here]
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
        height: 348.0,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: themeData.disabledColor))),
        child: Padding(
            padding: const EdgeInsets.all(16.0), child: _getEnterSection()));
  }
}
