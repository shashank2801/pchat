import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:pchat/routes.dart';
import 'package:pchat/services/authService.dart';


import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  //main is async
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
  }

class FlashChat extends StatelessWidget {
  //final Future<FirebaseApp> _init = Firebase.initializeApp();
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
        //initialRoute: Routes.welcome_screen,
        routes: {
          Routes.welcome_screen : (context) => WelcomeScreen(),
          Routes.login_screen : (context) => LoginScreen(),
          Routes.registration_screen : (context) => RegistrationScreen(),
          Routes.chat_screen : (context) => ChatScreen(),
        },
        home: MyHome(),
      ),
    );
  }
  
  
//   Widget build(BuildContext context){
//     return FutureBuilder(
//       future: _init,
//       builder: (context,snapshot){
//         if(snapshot.hasError){
//           return Text("Error");
//         }

//         if(snapshot.connectionState == ConnectionState.done){
//           return StreamProvider( 
//             initialData: null,
//             value: AuthenticationService(_firebaseAuth).myUser,
//             child: MaterialApp(
//               debugShowCheckedModeBanner: false,
//         //initialRoute: Routes.welcome_screen,
//         routes: {
//           Routes.welcome_screen : (context) => WelcomeScreen(),
//           Routes.login_screen : (context) => LoginScreen(),
//           Routes.registration_screen : (context) => RegistrationScreen(),
//           Routes.chat_screen : (context) => ChatScreen(),
//         },
//         home: MyHome(),
//             ),
//           );
//         }

//         return CircularProgressIndicator();
//       }
//       );
//   }
}

class MyHome extends StatelessWidget {

  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();
    // final firebaseuser = context.watch<User>();
    if(firebaseuser != null){
      Navigator.pop(context);
      return ChatScreen();
    }

    return WelcomeScreen();
  }
}
