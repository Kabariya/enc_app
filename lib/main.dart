import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String> loadAsset() async {

    ByteData _byteData = await rootBundle.load('assets/test1.jpg');


    // _byteData.buffer.as

    String img64 = base64Encode(_byteData.buffer.asUint8List());
    print(img64.substring(0, 100));

    // print("Hello --> $_byteData");

    return img64;



    // return _byteData;

    // _byteData.buffer.asUint8List();

    //
    // Int16List _int16List = _byteData.buffer.asInt16List();
    //
    // String hhh = await rootBundle.loadString('assets/test.text');

    // return await rootBundle.loadString('assets/test1.jpg');
  }

  @override
  void initState() {
    super.initState();

    // encDecFile();
  }

  Future<String> getDecode() async {

    // String _byteData = await loadAsset();
    // String fileString = "hello";
    // print("File -> $fileString");

    String _byteData = await rootBundle.loadString('assets/demoTextFile.txt');

    //TODO - key
    //TODO - enc
    //TODO - dec

    final key = enc.Key.fromUtf8('my 32 length key................');
    final iv = enc.IV.fromLength(16);

    final encrypter = enc.Encrypter(enc.AES(key));

    // final encrypted = encrypter.encrypt(_byteData, iv: iv);
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(_byteData), iv: iv);

    // String decrypted11 = encrypter.decrypt16(_byteData, iv: iv);

    print('hello  1111 --> $decrypted');

      return decrypted;

    // print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    // print(encrypted
    //     .base64); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==


  }

  Future<void> encDecFile() async {
    String _byteData = await loadAsset();
    // String fileString = "hello";
    // print("File -> $fileString");

    //TODO - key
    //TODO - enc
    //TODO - dec

    final key = enc.Key.fromUtf8('my 32 length key................');
    final iv = enc.IV.fromLength(16);

    final encrypter = enc.Encrypter(enc.AES(key));

    final encrypted = encrypter.encrypt(_byteData, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);



    print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    print(encrypted
        .base64); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==


    // Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    // String appDocumentsPath = appDocumentsDirectory.path; // 2
    // String filePath = '$appDocumentsPath/demoTextFile.text'; // 3


    File file = File(await getFilePath()); // 1
    file.writeAsString(encrypted.base64); // 2


  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

    print("FilePAth --> $filePath");

    return filePath;
  }

  Future<File> getFile() async {

    File file = File(await getFilePath());
    return file;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
        appBar: AppBar(
          title: Text("Enc Demo"),
        ),
        body: Column(
          children: [
            Container(),
            // FutureBuilder(
            //   builder: (context, snapshot) {
            //     return Image.asset("assets/test1.jpg");
            //   },
            // ),
            FutureBuilder(
              future: getDecode(),
              builder: (context, snapshot) {

                if(snapshot.hasData){

                final decodedBytes = base64Decode(snapshot.data);

                return Image.memory(decodedBytes);
                }else{
                  return Text("No image");
                }


              },
            ),
          ],
        ),
      ),
    );
  }
}
