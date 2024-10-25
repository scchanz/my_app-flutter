import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp()); //memanggil fungsi runAPP (menjalankan seluruh apk di dalam myAPP)
}

class MyApp extends StatelessWidget { //membuat apk abstrak dari statelessWidget (template apk), apk nya bernama MyAPP
  const MyApp({super.key}); //Menunjukan bahwa apk ini akan tetap, tidak dapat berubah setalah build

  @override //mengganti nilai lama yg sudah ada di template, dengan nilai-nilai yg baru (replace/over write)
  Widget build(BuildContext context) { //fungsi build yg membangun UI (mengatur posisi widget)
    return ChangeNotifierProvider(  //ChangeNotifierProvider mendengarkan/mendeteksi semua interaksi yang terjadi di apk(like pada post)
      create: (context) => 
      MyAppState(), //s
      child: MaterialApp( //pada state ini, menggunakan style desain materialUI
        title: 'Bocil Page', //diberi judul (NamerApp)
        theme: ThemeData( //data tema apklikasi, diberi warna (deepOrange)
          useMaterial3: true, //versi MAterialUI yang dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

 //mendefinisikan MyAppstate
class MyAppState extends ChangeNotifier { //state MyAppState diisi dengan 2 kata random yang digabungkan. kata random tsb disimpan di variable WordPair
  var current = WordPair.random();
  var Favorites = <WordPair>[];
  var selectedIndex = 0;
  var selectedIndexInAnotherWidget = 0;
  var IndexInYetAnotherWidget = 42;
  var optionASelected = false;
  var optionBSelected = false;
  var loadingFromNetwork = false;



  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
  
  //Menambahkan like button
  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

//membuat layout pada halaman HomePage
// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0; 

  @override
  Widget build(BuildContext context) {
    
Widget page;
switch (selectedIndex) {
  case 0:
    page = GeneratorPage();
    break;
  case 1:
    page = Placeholder();
    break;
  default:
    throw UnimplementedError('no widget for $selectedIndex');
} 
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value)  {

                setState(() {
                  selectedIndex = value;
                });
              
              }
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: GeneratorPage(),
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ...
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
      final theme = Theme.of(context); 
      final style = theme.textTheme.displayMedium!.copyWith(  
      color: theme.colorScheme.onPrimary,
    );

    return Card(
       color: theme.colorScheme.primary, 
      child: Padding(
        padding: const EdgeInsets.all(20),
           child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
           ),
      ),
    );
  }
}