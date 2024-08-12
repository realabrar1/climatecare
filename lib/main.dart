// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
// import 'package:careclimate/features/app/splash_screen/splash_screen.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/home_page.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/login_page.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/sign_up_page.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   if (kIsWeb) {
//     await Firebase.initializeApp(
//       options: FirebaseOptions(
//         apiKey: "AIzaSyDvmBohqmLhgAv0bZSRg-hUVcWAPDxqQHc",
//         appId: "1:189797188339:web:6b04cc7c4f16749793ed86",
//         messagingSenderId: "189797188339",
//         projectId: "careclimate-95ea3",

//         // Your web Firebase config options
//       ),
//     );
//   } else {
//     await Firebase.initializeApp();
//   }
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Climate Care',
//       routes: {
//         '/': (context) => SplashScreen(
//               // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
//               child: LoginPage(),
//             ),
//         '/login': (context) => LoginPage(),
//         '/signUp': (context) => SignUpPage(),
//         '/home': (context) => HomePage(),
//       },
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:careclimate/features/app/splash_screen/splash_screen.dart';
import 'package:careclimate/features/user_auth/presentation/pages/home_page.dart';
import 'package:careclimate/features/user_auth/presentation/pages/login_page.dart';
import 'package:careclimate/features/user_auth/presentation/pages/sign_up_page.dart';
import 'features/user_auth/presentation/pages/community_page.dart';
import 'features/user_auth/presentation/pages/profile_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDvmBohqmLhgAv0bZSRg-hUVcWAPDxqQHc",
        appId: "1:189797188339:web:6b04cc7c4f16749793ed86",
        messagingSenderId: "189797188339",
        projectId: "careclimate-95ea3",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Climate Care',
      routes: {
        '/': (context) => SplashScreen(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
              child: LoginPage(),
            ),

        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/community': (context) =>
            CommunityPage(), // Add route for CommunityPage
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
