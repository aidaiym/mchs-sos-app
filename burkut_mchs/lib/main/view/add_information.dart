import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:burkut_mchs/constants/app/app_text_styles.dart';

class AddInformationsPage extends StatefulWidget {
  const AddInformationsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddInformationsPageState createState() => _AddInformationsPageState();
}

class _AddInformationsPageState extends State<AddInformationsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addNews() async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('news').add({
          'title': title,
          'description': description,
          'created_at': FieldValue.serverTimestamp(),
        });
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Маалымат ийгиликтүү кошулду',
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

        _titleController.clear();
        _descriptionController.clear();
      } catch (e) {
        log('Error $e');
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Ката'),
              content: const Text(
                  'Маалымат кошулбай калды. Сураныч, кайра аракет кылыңыз.'),
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
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ката'),
            content: const Text('Аталышы жана сүрөттөмөсү бош болбошу керек.'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              TextField(
                controller: _titleController,
                    minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Aталышы',
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
              const SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                minLines: 4,
                maxLines: 200,
                decoration: InputDecoration(
                  hintText: 'Маалымат',
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
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _addNews,
                child: const Text('Маалымат кошуу'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
