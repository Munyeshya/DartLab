import 'package:flutter/material.dart';

void main() => runApp(const TextDisplay());

class TextDisplay extends StatelessWidget {
  const TextDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My first flutter Application',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Container(
            color: Colors.grey[200],
            // padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                    child: ListView(
                      children: const [
                        HoverMenuItem(title: 'Menu 1'),
                        HoverMenuItem(title: 'Menu 2'),
                        HoverMenuItem(title: 'Menu 3'),
                        HoverMenuItem(title: 'Menu 4'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.green,
                    child: ListView(
                      padding: const EdgeInsets.all(8.0),
                      children: const [
                        Card(
                          child: ListTile(
                            title: Text('Card 1'),
                            subtitle: Text('Description of Card 1'),
                            
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Card 2'),
                            subtitle: Text('Description of Card 2'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Card 3'),
                            subtitle: Text('Description of Card 3'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Card 4'),
                            subtitle: Text('Description of Card 4'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            'Footer Text',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class HoverMenuItem extends StatefulWidget {
  final String title;

  const HoverMenuItem({Key? key, required this.title}) : super(key: key);

  @override
  _HoverMenuItemState createState() => _HoverMenuItemState();
}

class _HoverMenuItemState extends State<HoverMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Add your onTap functionality here
      },
      onHover: (isHovered) {
        setState(() {
          _isHovered = isHovered;
        });
      },
      child: Container(
        color: _isHovered ? Colors.redAccent : Colors.red,
        child: ListTile(
          title: Text(
            widget.title,
            style: TextStyle(
              color: _isHovered ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
