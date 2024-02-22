import 'package:flutter/material.dart';
import 'package:indrecoder/indrecord_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/services.dart';
import 'package:indrecoder/button_comp.dart';
import 'package:indrecoder/circle_button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:indrecoder/firebase_options.dart';

class LoginPage1 extends StatefulWidget {
  @override
  State<LoginPage1> createState() => _LoginPage1();
}

class _LoginPage1 extends State<LoginPage1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFF010314),
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Container(
          width: screenwidth,
          padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.height,
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage2()));
                },
                child: Text(
                'IndRecord',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              ),
              200.height,
              SelectButton(
                title: 'Google auth',
                width: screenwidth * 0.8,
                prefix: 'google',
                onPressed: () async {
                  await signInWithGoogle();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage2()));
                },
              ),
              SelectButton(
                title: 'App auth',
                width: screenwidth * 0.8,
                prefix: 'apple',
              ),
              100.height
            ],
          ),
        ));
  
  }
}

class LoginPage2 extends StatefulWidget {
  @override
  State<LoginPage2> createState() => _LoginPage2();
}

class _LoginPage2 extends State<LoginPage2> {
  PageController? _pageController;
  int currentpage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentpage,
    );
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color(0xFF010314),
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Container(
          width: screenwidth,
          padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.height,
              Text(
                'IndRecord',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: screenwidth * 0.7,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF7EE8F6).withOpacity(0.57)),
                    )),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 220,
                  child: Stack(children: [
                    Container(
                        height: 200,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (value) {
                            setState(() {
                              currentpage = value;
                            });
                          },
                          children: [
                            for (int i = 0; i < 3; i++)
                              Container(
                                  child: Image.asset('assets/image/hi.png'))
                          ],
                        )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: DotsIndicator(
                        dotsCount: 3,
                        position: currentpage,
                        decorator: DotsDecorator(
                          activeColor: Colors.white,
                          color: Colors.grey,
                          size: const Size.square(10),
                          activeSize: const Size(10.0, 10.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    )
                  ])),
              Container(
                alignment: Alignment.center,
                width: screenwidth * 0.7,
                child: Text(
                  'Welcome to IndRecord',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: screenwidth * 0.7,
                child: Text(
                  'Please read our privacy policy',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              20.height,
              Container(
                width: screenwidth * 0.8,
                alignment: Alignment.centerRight,
                child: Circlebutton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage3()));
                  },
                ),
              ),
              100.height
            ],
          ),
        ));
  }
}

class LoginPage3 extends StatefulWidget {
  @override
  State<LoginPage3> createState() => _LoginPage3();
}

class _LoginPage3 extends State<LoginPage3> {
  PageController? _pageController;
  int currentpage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentpage,
    );
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color(0xFF010314),
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Container(
          width: screenwidth,
          padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.height,
              Text(
                'IndRecord',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              50.height,
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 220,
                  child: Stack(children: [
                    Container(
                        height: 200,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (value) {
                            setState(() {
                              currentpage = value;
                            });
                          },
                          children: [
                            for (int i = 0; i < 3; i++)
                              Container(
                                  child: Image.asset('assets/image/hi.png'))
                          ],
                        )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: DotsIndicator(
                        dotsCount: 3,
                        position: currentpage,
                        decorator: DotsDecorator(
                          activeColor: Colors.white,
                          color: Colors.grey,
                          size: const Size.square(10),
                          activeSize: const Size(10.0, 10.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    )
                  ])),
              Container(
                alignment: Alignment.center,
                width: screenwidth * 0.7,
                child: Text(
                  'Welcome to IndRecord',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: screenwidth * 0.7,
                child: Text(
                  'Please read our privacy policy',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              20.height,
              Container(
                  alignment: Alignment.center,
                  width: screenwidth * 0.7,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF7EE8F6).withOpacity(0.57),
                  ),
                  child: Container(
                    width: screenwidth * 0.7,
                    height: 40,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndRecord()));
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  )),
              Container(
                alignment: Alignment.center,
                width: screenwidth * 0.7,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF7EE8F6).withOpacity(0.57)),
                    )),
              ),
              100.height
            ],
          ),
        ));
  }
}
