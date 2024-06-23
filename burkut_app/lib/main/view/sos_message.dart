import 'dart:async';
import 'dart:developer';
import 'package:alarm/alarm.dart';
import 'package:burkut_app/constants/contants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';

class SosMessage extends StatefulWidget {
  const SosMessage({Key? key}) : super(key: key);

  @override
  State<SosMessage> createState() => _SosMessageState();
}

class _SosMessageState extends State<SosMessage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _audioUrl;
  bool _isPlaying = false;
  double _currentPosition = 0.0;
  late Timer _timer;
  late DateTime lastModified;
  late AlarmSettings alarmSettings;

  @override
  void initState() {
    super.initState();
    _initializeAudio();
    _startPollingForUpdates();
  }

  Future<void> _initializeAudio() async {
    try {
      await _retrieveLastAudio();
      _audioPlayer.onPlayerStateChanged.listen((event) {
        if (event == PlayerState.completed) {
          setState(() {
            _isPlaying = false;
            _currentPosition = 0.0;
          });
        }
      });
      alarmSettings = AlarmSettings(
        id: 1,
        // dateTime: lastModified,
        dateTime: DateTime(2024, 2, 16, 11, 51),

        assetAudioPath: 'lastAudioUrl',
        loopAudio: true,
        vibrate: true,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: 'ӨКМ',
        notificationBody: 'Ыкчам кабар',
        enableNotificationOnKill: true,
      );
      await Alarm.set(alarmSettings: alarmSettings);
    } catch (e) {
      log('Error initializing audio: $e');
    }
  }

  Future<void> _retrieveLastAudio() async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('audio');
      ListResult result = await ref.listAll();
      String lastAudioUrl = await result.items.last.getDownloadURL();

      setState(() {
        _audioUrl = lastAudioUrl;
      });
    } catch (e) {
      log('Error retrieving last audio: $e');
    }
  }

  void _playAudio() {
    if (_audioUrl != null) {
      _audioPlayer.play(UrlSource(_audioUrl!),
          position: Duration(seconds: _currentPosition.toInt()));
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _pauseAudio() {
    _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _startPollingForUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _retrieveLastAudio();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _timer.cancel();
    super.dispose();
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
          'Ыкчам кабар',
          style: AppTextStyles.black16,
        ),
        elevation: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (_isPlaying)
                ? Image.asset('assets/gif/giphy.gif')
                : Image.asset('assets/gif/giphy.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _isPlaying ? _pauseAudio : _playAudio,
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 100,
                  ),
                ),
                if (_isPlaying)
                  IconButton(
                    onPressed: _pauseAudio,
                    icon: const Icon(
                      Icons.stop,
                      size: 100,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
