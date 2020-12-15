part of 'pages.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 1;
  static List<Widget> _widgetOptions = <Widget>[
    AddPage(),
    DataPage(),
    AccountPage()
  ];
  void _onItemtapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle), 
              label: 'Add Data'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), 
              label: 'List Data'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), 
              label: 'My Account'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemtapped,
      ),
    );
  }
}
