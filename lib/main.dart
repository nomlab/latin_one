import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => Page(),
        '/inbox': (BuildContext context) => InboxPage(),
      },
    );
  }
}

class Page extends StatefulWidget {
  @override
  Pages createState() => Pages();
}

class Pages extends State<Page> {
  int _selectedIndex = 0;
  final _pageWidgets = [
    HomePage(),
    ShopsPage(),
    OrderPage(),
  ];
  void _onItemTapped(int index) => setState(() => _selectedIndex = index );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Standard AppBar',
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'LatinOne',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/inbox');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/inbox_icon.png',
                    fit: BoxFit.contain,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          body: _pageWidgets.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'shops',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'order',
              ),
            ],
          ),
        )
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  var mainPageState = context.findAncestorStateOfType<Pages>();
                  if (mainPageState != null) {
                    mainPageState._onItemTapped(2);
                  }
                },
                child: Container(
                    margin: EdgeInsets.all(10), width: 350, height:200 ,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue),
                    child: Text(
                        'order',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white
                        )
                    ),
                    alignment: Alignment.center
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10), width: 350, height:200 ,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red),
                  child: Text(
                      'Topic1',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white
                      )
                  ),
                  alignment: Alignment.center
              ),
              Container(
                  margin: EdgeInsets.all(10), width: 350, height:200 ,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green),
                  child: Text(
                      'Topic2',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white
                      )
                  ),
                  alignment: Alignment.center
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('To be continued...'),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shops'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('To be continued...'),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('To be continued...'),
            ],
          ),
        ),
      ),
    );
  }
}
