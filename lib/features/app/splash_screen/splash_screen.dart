// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   final Widget? child;
//   const SplashScreen({super.key, this.child});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/logo.jpeg',
//               width: 100, // Adjust the width as needed
//               height: 100, // Adjust the height as needed
//             ),
//             SizedBox(height: 20), // Space between logo and text
//             Text(
//               "Climate Care",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24, // Adjust the font size as needed
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/////////////////////////////////updated
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   final Widget? child;
//   const SplashScreen({super.key, this.child});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Future.delayed(Duration(seconds: 3), () {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => widget.child!),
//           (route) => false);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/logo.jpeg',
//               width: 100, // Adjust the width as needed
//               height: 100, // Adjust the height as needed
//             ),
//             SizedBox(height: 20), // Space between logo and text
//             Text(
//               "Climate Care",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24, // Adjust the font size as needed
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////////////////////////////
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (widget.child != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.jpeg',
              width: 100, // Adjust the width as needed
              height: 100, // Adjust the height as needed
            ),
            SizedBox(height: 20), // Space between logo and text
            Text(
              "Climate Care",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24, // Adjust the font size as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
