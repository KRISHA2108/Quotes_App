import 'headers.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.splashScreen: (context) => const SplashScreen(),
        Routes.homePage: (context) => const HomePage(),
        Routes.detailPage: (context) => const DetailPage(),
        Routes.categoryPage: (context) => const CategoryPage(),
      },
    );
  }
}
