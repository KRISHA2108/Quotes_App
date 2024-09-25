import 'package:quotes_application/headers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void changeScreen(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacementNamed(
          Routes.homePage,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    changeScreen(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "lib/assets/images/Amazing-HD-Black-Wallpapers.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quotes....",
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
            Text(
              "Let's Start....",
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
