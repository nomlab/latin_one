import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LatinOne',
      home: const Page(title: 'LatinOne'),
      routes: <String, WidgetBuilder> {
        '/inbox': (BuildContext context) => new InboxPage(),
        '/topic1': (BuildContext context) => new Topic1Page(),
        '/topic2': (BuildContext context) => new Topic2Page(),
        '/shopinfo': (BuildContext context) => new ShopInfoPage(),
      },
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.title});
  final String title;
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
            backgroundColor: Colors.brown,
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
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'shops',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
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
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  var mainPageState = context.findAncestorStateOfType<Pages>();
                  mainPageState?._onItemTapped(2);
                },
                child: Container(
                    margin: EdgeInsets.all(10), width: 350, height:200 ,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/coffee.jpg'),
                          fit: BoxFit.cover,
                        )
                    ),
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
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Topic1Page()));
                },
                child: Container(
                    margin: EdgeInsets.all(10), width: 350, height:200 ,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/IMG_8836.jpg'),
                          fit: BoxFit.cover,
                        )
                    ),
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
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Topic2Page()));
                },
                child: Container(
                    margin: EdgeInsets.all(10), width: 350, height:200 ,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/IMG_8837.jpg'),
                          fit: BoxFit.cover,
                        )
                    ),
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


class ShopsPage extends StatefulWidget {
  @override
  State<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(vsync: this);

  void _showAlert(LatLng latlng) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('ピンの位置 : latin_coffee'),
            content: Text(
                '〒781-5101\n 高知県高知市布師田3061\n'
                '緯度: ${33.57453}, 経度: ${133.57860}',
              style: TextStyle(fontSize: 20.0),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('詳細'),
                onPressed: () {
                  Navigator.of(context).pop(); // ダイアログを閉じる
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopInfoPage()),
                  );
                },
              ),
              TextButton(
                child: const Text('閉じる'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('〒781-5101 高知県高知市布師田3061',
          style: TextStyle(fontSize: 16.0),),
      ),
      body: FlutterMap(
        // mapControllerをFlutterMapに指定
        mapController: _animatedMapController.mapController,
        options: MapOptions(
          // Latin coffeeの緯度経度です。
          initialCenter: LatLng(33.57453, 133.57860),
          initialZoom: 15,
          minZoom: 10,
          maxZoom: 20,
          onTap: (tapPosition, point) {
            _showAlert(point); // タップした位置でアラートを表示
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://cyberjapandata.gsi.go.jp/xyz/seamlessphoto/{z}/{x}/{y}.jpg',
          ),
          const MarkerLayer(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                // ピンの位置を設定
                point: LatLng(33.57453, 133.57860),
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  // ここでピンのサイズを調整
                  size: 50,
                ),
                // マップを回転させた時にピンも回転するのが rotate: false,
                // マップを回転させた時にピンは常に同じ向きなのが rotate: true,
                rotate: true,
              ),
            ],
          ),
        ],
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

class Topic1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topic1'),
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

class Topic2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topic2'),
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

class ShopInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopInfo'),
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