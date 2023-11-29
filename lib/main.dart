import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DotScript',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Icons.coronavirus_sharp,
            nextScreen: const HomeScreen(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.grey.shade800));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.7,
              image: AssetImage('assets/abstract.jpg'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'DotScript',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Where all your medical questions are answered.',
                  style: TextStyle(color: Colors.grey[900], fontSize: 20),
                ),
                const SizedBox(height: 20),
                Text(
                  'It is a medical information system designed to provide you reliable and easily accessible information about various diseases, drugs, and symptoms. It serves as a one-stop resource for individuals seeking accurate medical information, aiding in self-education and informed decision-making about their health.',
                  style: TextStyle(color: Colors.grey[50], fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'You can click on the given buttons to access your required bot.',
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _navigateToPage(context, const MedicalPage());
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                        backgroundColor: Colors.grey.shade900,
                      ),
                      child: const Text(
                        'For Generic Queries',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _navigateToPage(context, const DataPage());
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                        backgroundColor: Colors.grey.shade900,
                      ),
                      child: const Text(
                        'For Genetic Queries',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}

class MedicalPage extends StatelessWidget {
  const MedicalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ask your Question',
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller.loadUrl('assets/generic.html');
        },
      ),
    );
  }
}

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask your Question'),
        backgroundColor: Colors.black12,
      ),
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller.loadUrl('assets/genetic.html');
        },
      ),
    );
  }
}
