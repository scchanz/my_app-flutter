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
        title: 'Namer App', //diberi judul (NamerApp)
        theme: ThemeData( //data tema apklikasi, diberi warna (deepOrange)
          useMaterial3: true, //versi MAterialUI yang dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
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

    //di bawah ini adalah kode program untuk menyusun layout
    return Scaffold(
      body: Column(
        children: [
          Text('A random idea:'),
          Text(appState.current.asLowerCase), //mengambil random text dari appstate pada variable WordPair current, lalu diubah menjadi huruf kecil semua
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