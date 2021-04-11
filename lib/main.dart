import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';


import 'package:pchat/routes.dart';
import 'package:pchat/services/authService.dart';
import 'package:pchat/wrapper.dart';


import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirebaseTrial());
  }

class FirebaseTrial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),

        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null, 
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        routes: {
          Routes.welcome_screen : (context) => WelcomeScreen(),
          Routes.login_screen : (context) => LoginScreen(),
          Routes.registration_screen : (context) => RegistrationScreen(),
          Routes.home_screen : (context) => HomeScreen(),
        },
        home: WrapperClass(),
      ),
    );
  }
}

