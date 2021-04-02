import 'dart:html';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/test.text');
  }

  @override
  void initState() {
    super.initState();

    encDecFile();
  }

  Future<void> encDecFile() async {
    String fileString = await loadAsset();
    print("File -> $fileString");

    //TODO - key
    //TODO - enc
    //TODO - dec

    final key = enc.Key.fromUtf8('my 32 length key................');
    final iv = enc.IV.fromLength(16);

    final encrypter = enc.Encrypter(enc.AES(key));

    final encrypted = encrypter.encrypt(fileString, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    print(encrypted
        .base64); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Enc Demo"),
        ),
        body: Column(
          children: [
            Container(),
            FutureBuilder(
              builder: (context, snapshot) {
                return Image.asset("assets/test1.jpg");
              },
            ),
          ],
        ),
      ),
    );
  }
}
