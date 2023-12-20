import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbl_stuhealth/awalan/halaman.dart';
import 'package:pbl_stuhealth/login/formlogin.dart';
import 'package:pbl_stuhealth/tengah/inti.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Menambahkan baris ini
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool firstLaunch = prefs.getBool('firstLaunch') ?? true;
//   runApp(MaterialApp(
//     title: 'StuHealth',
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//       colorScheme: ColorScheme.fromSwatch(
//         primarySwatch: Colors.teal,
//         brightness: Brightness.light,
//       ),
//     ),
//     home: const HalamanAwal(),
//     routes: <String, WidgetBuilder>{
//       '/HalamanAwal': (BuildContext context) => const HalamanAwal(),
//       '/HalamanKedua': (BuildContext context) => const HalamanKedua(),
//       '/HalamanKetiga': (BuildContext context) => const HalamanKetiga(),
//     },
//   ));
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Add this line
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool firstLaunch = prefs.getBool('firstLaunch') ?? true;
  bool loggedIn = prefs.getBool('loggedIn') ?? false;

  Widget homeWidget;

  if (firstLaunch) {
    homeWidget = HalamanAwal();
  } else {
    homeWidget = loggedIn ? IntiAplikasi() : HalamanLogin();
  }

  runApp(MaterialApp(
    title: 'StuHealth',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    ),
    home: homeWidget,
    routes: <String, WidgetBuilder>{
      '/HalamanAwal': (BuildContext context) => HalamanAwal(),
      '/HalamanKedua': (BuildContext context) => HalamanKedua(),
      '/HalamanKetiga': (BuildContext context) => HalamanKetiga(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
