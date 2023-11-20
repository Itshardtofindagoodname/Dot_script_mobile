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
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            height: 450,
            width: 375,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black.withAlpha(100),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.red, size: 20),
                    const Icon(Icons.circle, color: Colors.yellow, size: 20),
                    const Icon(Icons.circle, color: Colors.green, size: 20),
                    const SizedBox(width: 4),
                    Text('C:\\Users\\DotScript>',
                        style: TextStyle(color: Colors.grey.shade100)),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome to DotScript',
                  style: TextStyle(color: Colors.blue.shade200, fontSize: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  'Where all your medical questions are answered.',
                  style: TextStyle(color: Colors.grey[100], fontSize: 18),
                ),
                const SizedBox(height: 20),
                Text(
                  'It is a medical information system designed to provide you reliable and easily accessible information about various diseases, drugs, and symptoms. It serves as a one-stop resource for individuals seeking accurate medical information, aiding in self-education and informed decision-making about their health.',
                  style: TextStyle(color: Colors.grey[100], fontSize: 16),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _navigateToPage(context, const MedicalPage());
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        'For Generic Queries',
                        style: TextStyle(
                            color: Colors.tealAccent.shade400,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _navigateToPage(context, const DataPage());
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        'For Genetic Queries',
                        style: TextStyle(
                            color: Colors.blueGrey.shade300,
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
          controller.loadUrl('assets/medical.html');
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
          controller.loadUrl('assets/data.html');
        },
      ),
    );
  }
}
