import 'package:flutter/material.dart';
import 'package:novel_crawl/views/screens/OnBoarding.dart';
import 'package:novel_crawl/views/screens/homescreen.dart';
import 'package:novel_crawl/views/screens/navigationscreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  await hiveInit();
  runApp(MyApp());
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
  MyApp({super.key});
  bool isPermissionGranted = false;
  Future requestPermission() async {
    var status = await Permission.storage.status;
    isPermissionGranted = await Permission.manageExternalStorage.status.isGranted;

    if (!status.isGranted) {
      var status = await Permission.manageExternalStorage.request();
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: requestPermission(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading spinner while waiting for permission
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show error message if something went wrong
        } else {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            initialRoute: '/onboarding',
            routes: {
              '/onboarding': (context) => isPermissionGranted ? const NavigationScreen() : const OnBoarding(),
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
      },
    );
  }
}
