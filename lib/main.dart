import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:vocab_master/screen/quiz_by_unite.dart';
import 'package:vocab_master/screen/quiz_dashboard.dart';
import 'bloc/bloc/daily_words_bloc.dart';
import 'screen/add_words_screen.dart';
import 'screen/all_words.dart';
import 'bloc/get_word/get_word_bloc.dart';
import 'bloc/vocabluary/getvocabluary_bloc.dart';
import 'screen/daily_words_screen.dart';
import 'screen/essetianal_book_screen.dart';
import 'screen/quiz_screen.dart';
import 'services/hive_helper/hiveclass.dart';

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
  // IsarService().openDB();

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
    QuizDashboard(),
    EssetianalPage(),
    HiveWordsPage(),
    QuizByUnite(),
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
          actions: [
            IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddWordsScreen(),)), icon: ImageIcon(AssetImage('assets/images/add.png'),color: Colors.white,))
          ],
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
              icon: const ImageIcon(AssetImage("assets/images/ai_quiz.png")),
              label: ("Ai Quiz"),
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
              icon: const ImageIcon(AssetImage("assets/images/quiz.png")),
              label: ("Quiz"),
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

