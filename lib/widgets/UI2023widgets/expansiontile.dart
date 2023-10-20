import 'package:flutter/material.dart';

class MyCustomExpansionTile extends StatefulWidget {
  @override
  _MyCustomExpansionTileState createState() => _MyCustomExpansionTileState();
}

class _MyCustomExpansionTileState extends State<MyCustomExpansionTile> {
  bool isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: _toggleExpansion,
          child: Row(
            children: <Widget>[
              Text(
                'Expand / Collapse',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 30,
                color: Colors.blue,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Column(
            children: <Widget>[
              ListTile(
                title: Text('Item 1'),
              ),
              ListTile(
                title: Text('Item 2'),
              ),
            ],
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}
