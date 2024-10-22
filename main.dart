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
        title: 'Khns Page', //diberi judul (NamerApp)
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
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

//membuat layout pada halaman HomePage
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); //widget menggunakan state MyAppState
    var pair = appState.current; 

    //di bawah ini adalah kode program untuk menyusun layout
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('A random idea:'),
          BigCard(pair: pair), //mengambil nilai dari variable pair, lalu diubah menjadi huruf kecil semua, dan ditampilkan sebaagi date
           ElevatedButton( //membuat button timbul di dalam body
            onPressed: () { //fungsi yang dieksekusi ketika button ditekan
              appState.getNext();
            },
            child: Text('Next'), //berikan teks 'next' pada button (sebagai child)
          ),
        ],
      ),
    );
  }
}

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