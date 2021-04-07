
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pchat/components/Button.dart';


import '../routes.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _animation;

    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = ColorTween(begin: Colors.cyan, end: Colors.teal)
        .animate(_animationController);

    _animationController.forward();

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'Logo',
                  child: Container(
                    child: Image.asset('images/groupicon.jpg'),
                    height: 60.0,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                DefaultTextStyle(
                  style: TextStyle(
                      fontFamily: 'Ranchers',
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Chaar C'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Button(
              text: 'Log In',
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, Routes.login_screen);
              },
            ),
            Button(
              text: 'Register',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, Routes.registration_screen);
              },
            ),
            SizedBox(height:14),
            OutlinedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(Colors.cyanAccent),
                //shape: MaterialStateProperty.all<OutlinedBorder>(BorderRadius.circular(40)),
              ),


              //splashColor: Colors.cyanAccent,
              onPressed: () async {
                // final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
                // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

                // final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleUser.idToken,accessToken: googleUser.accessToken);
                // final User user = (await FirebaseAuth.signInWithCredential(credential)).user;
                try{
                  await _googleSignIn.signIn();
                  Navigator.pushNamed(context, Routes.chat_screen);
                }
                catch(e){
                  print(e);
                }
              },
              
              // highlightElevation: 4,
              // borderSide: BorderSide(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        image: AssetImage("images/google_logo.png"),
                        height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

