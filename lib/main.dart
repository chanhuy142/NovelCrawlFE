import 'package:flutter/material.dart';
import 'package:novel_crawl/screens/OnBoarding.dart';
import 'package:novel_crawl/screens/homescreen.dart';
import 'package:novel_crawl/screens/navigationscreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

void main() async {
  await hiveInit();
  runApp(const MyApp());
}

Future hiveInit() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnBoarding(),
        '/navigation': (context) => const NavigationScreen(),
        '/home': (context) => const HomePage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        canvasColor: Colors.black,
        splashColor: Colors.transparent,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          //DFD82C
          selectedItemColor: Color(0xFFDFD82C),
          unselectedItemColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const OnBoarding(),
    );
  }
}
