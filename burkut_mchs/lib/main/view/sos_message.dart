import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:burkut_mchs/constants/app/app_text_styles.dart';
import 'package:path_provider/path_provider.dart';

class SosMessage extends StatefulWidget {
  const SosMessage({Key? key}) : super(key: key);

  @override
  State<SosMessage> createState() => _SosMessageState();
}

class _SosMessageState extends State<SosMessage> {
  TextEditingController textController = TextEditingController();
  bool isLoading = false;

  Future<void> _sendTextToSpeechRequest() async {
    setState(() {
      isLoading = true;
    });

    String text = textController.text;
    String apiUrl = 'https://tts.ulut.kg/api/tts';
    String token =
        'RxXlmw4qMoTzvHcDSdK0phyLyUAjLCMTPw3CtvWrM1TVlB0k7LItcoaMH2fTpTpM';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'text': text,
          'speaker_id': 1,
        }),
      );
      if (response.statusCode == 200) {
        response.headers['content-disposition'] ?? '';
        final mp3Response = response.bodyBytes;

        File file = File('${(await getTemporaryDirectory()).path}/audio.mp3');
        await file.writeAsBytes(mp3Response);
        final firebaseStorage = FirebaseStorage.instance;
        final Reference storageRef = firebaseStorage
            .ref()
            .child('audio/${DateTime.now().millisecondsSinceEpoch}.mp3');

        final UploadTask uploadTask = storageRef.putFile(file);
        await uploadTask;
        String downloadUrl = await storageRef.getDownloadURL();
        log('Uploaded file URL: $downloadUrl');

        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Билдирүү ийгиликтүү жөнөтүлдү',
                textAlign: TextAlign.center,
                style: AppTextStyles.black19,
              ),
              content: Image.asset(
                'assets/images/success.png',
                width: 80,
                height: 80,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        textController.text = '';
      } else {
        throw Exception('Failed to send SOS message ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/icons/logo.png'),
        ),
        title: Text(
          'Өзгөчө кырдаалдар министрлиги',
          style: AppTextStyles.black16,
        ),
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                TextField(
                  controller: textController,
                  minLines: 7,
                  maxLines: 200,
                  decoration: InputDecoration(
                    hintText: 'Шашылыш билдирүү жазуу',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _sendTextToSpeechRequest();
                  },
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Жиберүү'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
