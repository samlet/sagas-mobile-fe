import 'package:flutter/material.dart';

class EnterAmountSection extends StatefulWidget {
  @override
  State<EnterAmountSection> createState() => _EnterAmountSectionState();
}

class _EnterAmountSectionState extends State<EnterAmountSection> {
  // final TextEditingController _textController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
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
                'Enter Amount',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '\$',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                        decoration: InputDecoration(
                            hintText: 'Amount',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30.0)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

