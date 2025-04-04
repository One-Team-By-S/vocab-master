// ignore_for_file: avoid_print, unused_field

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'bloc/bloc/daily_words_bloc.dart';
import 'screen/add_words_screen.dart';
import 'screen/all_words.dart';
import 'bloc/get_word/get_word_bloc.dart';
import 'bloc/vocabluary/getvocabluary_bloc.dart';
import 'screen/daily_words_screen.dart';
import 'screen/essetianal_book_screen.dart';
import 'screen/radn_words.dart';
import 'services/hive_helper/hiveclass.dart';
import 'services/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAmbc_ojG80nfO1AswCVxbZVIU90O_tsi8',
      appId: '1:53563810638:android:7cad2f603517d9c30d341f',
      messagingSenderId: '',
      projectId: 'fir-auth-86e00',
      storageBucket: '',
    ),
  );
  IsarService().openDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetWordBloc()..add(GetAllEvent())),
        BlocProvider(create: (context) => GetvocabluaryBloc()),
        BlocProvider(create: (context) => DailyWordsBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.transparent,
          ),
          primaryColor: const Color(0xff44B275),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: ''),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AllWordsScreen(),
    RandomWordsScreen(),
    EssetianalPage(),
    HiveWordsPage(),
    AddWordsScreen(),
  ];

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    print('checking for Update');
    InAppUpdate.checkForUpdate()
        .then((info) {
          setState(() {
            if (info.updateAvailability == UpdateAvailability.updateAvailable) {
              print('update available');
              update();
            }
          });
        })
        .catchError((e) {
          print(e.toString());
        });
  }

  void update() async {
    print('Updating');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      print(e.toString());
    });
  }

  // ignore: unused_element
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  ///////////////////

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Center(
            child: Text(
              'VocabMaster',
              style: GoogleFonts.alice(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: _widgetOptions.elementAt(index),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedLabelStyle: GoogleFonts.poppins(
            color: Colors.red,
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            color: Colors.red,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const ImageIcon(AssetImage("assets/images/house.png")),
              label: ("Words"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const ImageIcon(AssetImage("assets/images/grid.png")),
              label: ("Random"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.book),
              label: ("Essetianal"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const ImageIcon(AssetImage('assets/images/word.png')),
              label: ("Daily"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const ImageIcon(AssetImage("assets/images/add.png")),
              label: ("Add"),
            ),
          ],
          currentIndex: index,
          onTap: (int i) {
            setState(() {
              index = i;
            });
          },
          unselectedItemColor: Colors.white.withOpacity(0.5),
          fixedColor: Colors.white,
        ),
      ),
    );
  }
}

// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_translate/flutter_translate.dart';

// void main() async {
//   var delegate =   await LocalizationDelegate.create(
//       fallbackLocale: 'en_US',
//       supportedLocales: ['en_US', 'es', 'fa', 'ar', 'ru']);

//   runApp(LocalizedApp(delegate, MyApp()));
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var localizationDelegate = LocalizedApp.of(context).delegate;

//     return LocalizationProvider(
//       state: LocalizationProvider.of(context).state,
//       child: MaterialApp(
//         title: 'Flutter Translate Demo',
//         localizationsDelegates: [
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           localizationDelegate
//         ],
//         supportedLocales: localizationDelegate.supportedLocales,
//         locale: localizationDelegate.currentLocale,
//         theme: ThemeData(primarySwatch: Colors.blue),
//         home: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);
//   final String? title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _decrementCounter() => setState(() => _counter--);

//   void _incrementCounter() => setState(() => _counter++);

//   @override
//   Widget build(BuildContext context) {
//     var localizationDelegate = LocalizedApp.of(context).delegate;
// final translator = GoogleTranslator();
// translator.translate("l!", from: 'en', to: 'ru').then((s) {
//   print('********************************');
//   print(s);
// });
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(translate('app_bar.title')),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(translate('language.selected_message', args: {
//               'language': translate(
//                   'language.name.${localizationDelegate.currentLocale.languageCode}')
//             })),
//             Padding(
//                 padding: EdgeInsets.only(top: 25, bottom: 160),
//                 child: CupertinoButton.filled(
//                   child: Text(translate('button.change_language')),
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 10.0, horizontal: 36.0),
//                   onPressed: () => _onActionSheetPress(context),
//                 )),
//             Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: Text(translatePlural('plural.demo', _counter))),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.remove_circle),
//                   iconSize: 48,
//                   onPressed: _counter > 0
//                       ? () => setState(() => _decrementCounter())
//                       : null,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_circle),
//                   color: Colors.blue,
//                   iconSize: 48,
//                   onPressed: () => setState(() => _incrementCounter()),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void showDemoActionSheet(
//       {required BuildContext context, required Widget child}) {
//     showCupertinoModalPopup<String>(
//         context: context,
//         builder: (BuildContext context) => child).then((String? value) {
//       if (value != null) changeLocale(context, value);
//     });
//   }

//   void _onActionSheetPress(BuildContext context) {
//     showDemoActionSheet(
//       context: context,
//       child: CupertinoActionSheet(
//         title: Text(translate('language.selection.title')),
//         message: Text(translate('language.selection.message')),
//         actions: <Widget>[
//           CupertinoActionSheetAction(
//             child: Text(translate('language.name.en')),
//             onPressed: () => Navigator.pop(context, 'en_US'),
//           ),
//           CupertinoActionSheetAction(
//             child: Text(translate('language.name.es')),
//             onPressed: () => Navigator.pop(context, 'es'),
//           ),
//           CupertinoActionSheetAction(
//             child: Text(translate('language.name.ar')),
//             onPressed: () => Navigator.pop(context, 'ar'),
//           ),
//           CupertinoActionSheetAction(
//             child: Text(translate('language.name.ru')),
//             onPressed: () => Navigator.pop(context, 'ru'),
//           ),
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           child: Text(translate('button.cancel')),
//           isDefaultAction: true,
//           onPressed: () => Navigator.pop(context, null),
//         ),
//       ),
//     );
//   }
// }
