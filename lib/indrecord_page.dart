import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/services.dart';
import 'package:indrecoder/button_comp.dart';
import 'package:indrecoder/circle_button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:indrecoder/text_comp.dart';
import 'package:indrecoder/slider_comp.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:indrecoder/firebase_options.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class IndRecord extends StatefulWidget {
  @override
  State<IndRecord> createState() => _IndRecord();
}

File? file;

class _IndRecord extends State<IndRecord> {
  File? selectedFile;
  String? token;
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> processAudio(String email, String bucketname) async {
    var url = Uri.parse('http://34.78.156.216:8004/process_audio/');
    var data = {
      "query": email,
      "firebase_bucket_name": bucketname,
    };

    final requestBody = jsonEncode(data);
    print(requestBody);
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: requestBody);
    print(json.decode(response.body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Authentication successful, store the token
      // Store the token locally on the device
      // Example: SharedPreferences.getInstance().then((prefs) => prefs.setString('token', token));
      print('00');
    } else {
      // Authentication failed
      throw Exception('Failed to Access');
    }
  }

  Future<void> uploadFile(String email, String bucketname) async {
    var url = Uri.parse('http://34.78.156.216:8004/process_audio');
    var data = {
      "query": email,
      "firebase_bucket_name": bucketname,
    };

    final requestBody = jsonEncode(data);
    print(requestBody);
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: requestBody);
    print(json.decode(response.body)['task_id']);
    print(response.headers);
    token = json.decode(response.body)["task_id"];
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "lucaskeller522@gmail.com", password: "pwd1234!@#\$");
    final user = credential.user;
    if (user != null) {
      print('User signed in successfully: $user');
    }
    // Get the file name
    if (token != '')
      Timer.periodic(Duration(seconds: 1), (timer) {
        // Call your function here
        taskStatus(token!);
      });
    String fileName =
        "data/audios/lucaskeller522@gmail.com" + "_$token" + "_last.m4a";
    FirebaseStorage storage = FirebaseStorage.instance;
    // FirebaseAuth auth = FirebaseAuth.instance;
    // User? user = auth.currentUser;
    // String userId = user!.uid;
    // UserCredential userCredential =
    //     await FirebaseAuth.instance.signInAnonymously();
    // print('User ID: ${userCredential.user!.uid}');
    // Create a reference to the location where the file will be uploaded
    Reference storageReference = storage.ref().child('$fileName');

    // Upload the file to Firebase Storage
    TaskSnapshot uploadTask = await storageReference.putFile(selectedFile!);

    // Listen for state changes, errors, and completion of the upload
    String downloadurl = await uploadTask.ref.getDownloadURL();
    print(downloadurl);
  }

  Future<void> taskStatus(String taskId) async {
    var url = Uri.parse('http://34.78.156.216:8004/tasks/$taskId');
    var object = {'Accept': 'application/json'};
    final response = await http.get(url, headers: object);
    if (response.statusCode == 200) {
      // Logout successful, clear user-related data or tokens
      print(json.decode(response.body));
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xFF010314),
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: screenwidth,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
              Color(0xFF7EE8F6).withOpacity(0.57),
              Color(0xFF010314)
            ], center: Alignment(0, -0.5), radius: 0.9)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(0),
                  width: screenwidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.settings),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      20.width,
                      Text(
                        'Hi, Michael 👏',
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.9), fontSize: 20),
                      ),
                      60.width
                    ],
                  ),
                ),
                20.height,
                Container(
                    alignment: Alignment.center,
                    width: screenwidth * 0.9,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color(0xFF7EE8F6).withOpacity(0.57),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                        alignment: Alignment.center,
                        width: screenwidth * 0.9,
                        height: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF010314),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            10.height,
                            TextModel(
                              image: 'done',
                              title: '',
                              width: screenwidth * 0.5,
                            ),
                            Text(
                                'Summary for IndRecord will be here as \n simple text which you can copy/paste',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    width: screenwidth * 0.3,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.transparent,
                                    ),
                                    child: Container(
                                      width: screenwidth * 0.3,
                                      height: 35,
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                width: 1.0,
                                                color: Colors.white),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'Full text',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          )),
                                    )),
                                20.width,
                                Container(
                                    alignment: Alignment.center,
                                    width: screenwidth * 0.4,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.transparent,
                                    ),
                                    child: Container(
                                      width: screenwidth * 0.4,
                                      height: 35,
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                width: 1.0,
                                                color: Color(0xFF2B69A8)),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          onPressed: () async {
                                            await processAudio(
                                                "lucaskeller522@gmail.com",
                                                "softwaredev");
                                          },
                                          child: Text(
                                            'Full Summary',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          )),
                                    )),
                              ],
                            ),
                            10.height
                          ],
                        ))),
                10.height,
                Container(
                    alignment: Alignment.center,
                    width: screenwidth * 0.9,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                        border: Border.all(width: 1.0, color: Colors.white)),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Speaker1',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Speaker1',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Speaker1',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Speaker1',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              '...',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ))
                      ],
                    )),
                10.height,
                Container(
                  alignment: Alignment.center,
                  width: screenwidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Speaker1',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Image.asset(
                        'assets/image/Edit.png',
                      )
                    ],
                  ),
                ),
                10.height,
                Container(
                    alignment: Alignment.center,
                    width: screenwidth * 0.9,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        border: Border.all(width: 1.0, color: Colors.white)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          20.width,
                          Image.asset('assets/image/score.png'),
                          10.width,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Personality Score',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              Text('8/10',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))
                            ],
                          )
                        ])),
                10.height,
                Container(
                    width: screenwidth * 0.9,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Slidermodel(
                                  title: ' Trust',
                                  width: screenwidth * 0.4,
                                  value: 0,
                                ),
                                Slidermodel(
                                  title: ' Sentiment',
                                  width: screenwidth * 0.4,
                                  value: 0,
                                ),
                              ],
                            ),
                            5.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Slidermodel(
                                  title: ' Empathy',
                                  width: screenwidth * 0.4,
                                  value: 0,
                                ),
                                Slidermodel(
                                  title: ' Charisma',
                                  width: screenwidth * 0.4,
                                  value: 0,
                                ),
                              ],
                            ),
                            5.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Slidermodel(
                                  title: ' Trust',
                                  width: screenwidth * 0.4,
                                  value: 0,
                                ),
                                Slidermodel(
                                  title: ' Sentiment',
                                  width: screenwidth * 0.4,
                                  value: 0,
                                ),
                              ],
                            ),
                            5.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Slidermodel(
                                  title: ' Empathy',
                                  width: screenwidth * 0.4,
                                  value: 0,
                                ),
                                Slidermodel(
                                  title: ' Charisma',
                                  width: screenwidth * 0.4,
                                  value: 0,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.white, width: 2.0))),
                              child: Row(
                                children: [
                                  Text(
                                    'Sort by',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Image.asset('assets/image/below.png')
                                ],
                              ),
                            ))
                      ],
                    )),
                20.height,
                Container(
                  width: screenwidth * 0.9,
                  child: Column(
                    children: [
                      Text(
                        'Favourite topics and interests',
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.7), fontSize: 20),
                      ),
                      5.height,
                      TextModel(
                          image: 'none',
                          width: screenwidth * 0.8,
                          title: 'Sport. Speaker mentioned he likes a golf...')
                    ],
                  ),
                ),
                20.height,
                Container(
                  width: screenwidth * 0.9,
                  child: Column(
                    children: [
                      Text(
                        'Contradictions in statements',
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.7), fontSize: 20),
                      ),
                      5.height,
                      TextModel(
                          image: 'none',
                          width: screenwidth * 0.8,
                          title:
                              'First, speaker mentioned he keeps a healthy\nlifestyle, but he likes alcohol as well...')
                    ],
                  ),
                ),
                25.height,
                Container(
                    width: screenwidth,
                    height: 100,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 40,
                            ),
                            Container(
                              height: 60,
                              color: const Color.fromARGB(255, 43, 41, 41),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenwidth / 2,
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.save,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Records',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenwidth / 2,
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/image/analytics.png',
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Insight',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Positioned(
                            top: 0,
                            left: screenwidth / 2 - 40,
                            child: Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.transparent,
                                    border: Border.all(
                                        width: 2.0,
                                        color: Color(0xFF4CA7E8)
                                            .withOpacity(0.1))),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      color: Colors.transparent,
                                      border: Border.all(
                                          width: 2.0,
                                          color: Color(0xFF4CA7E8)
                                              .withOpacity(0.25))),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.transparent,
                                        border: Border.all(
                                            width: 2.0,
                                            color: Color(0xFF4CA7E8)
                                                .withOpacity(0.5))),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Color(0xFF7EE8F6),
                                      ),
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            side: BorderSide.none,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(23)),
                                          ),
                                          onPressed: () async {
                                            await pickFile();
                                            await uploadFile(
                                                'lucaskeller522@gmail.com',
                                                'softwaredev');
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                  'assets/image/mike.png'))),
                                    ),
                                  ),
                                )))
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
