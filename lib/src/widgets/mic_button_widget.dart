import 'dart:math';

import 'package:dialogflowexample/src/providers/provider.dart';
import 'package:dialogflowexample/src/services/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/v2/dialogflow_v2.dart';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:dialogflowexample/src/providers/dialogflow_provider.dart';


class MicWidget extends StatefulWidget {
  final ProviderProvider provider;

  MicWidget({@required this.provider});

  @override
  _MicWidgetState createState() => _MicWidgetState();
}

class _MicWidgetState extends State<MicWidget> {

  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  SpeechToText speech = SpeechToText();
  String _currentLocaleId = 'es_US';
  bool _hasSpeech = false;
  String intent = '';
  SpeechRecognitionResult result;
  final dialogflow = DialogflowProvider(fileJson: "assets/taller-call-ddd1a997ca47.json");
  bool oneTime = false;

  @override
  void initState()  {
    initSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return FloatingActionButton(
      child: Icon(Icons.mic,color: speech.isListening ? Colors.redAccent : Colors.white,),
      backgroundColor: Colors.teal,
      onPressed: ()  {
        if(!_hasSpeech || !speech.isListening){
          oneTime = true;
        startListening();}
        },
    );
  }


  Future<void> initSpeech() async {
    bool hasSpeech = await speech.initialize( onStatus: statusListener, onError: errorListener );
    if (!mounted) return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }


  void errorListener(SpeechRecognitionError error) {

    lastError = "${error.errorMsg} - ${error.permanent}";
  }

  void statusListener(String status) {

    lastStatus = "$status";

  }

  void resultListener(SpeechRecognitionResult result) async {
    if (result.finalResult) {
      setState(() {
        lastWords = result.recognizedWords;
      });
      if(oneTime) {
        widget.provider.sstText = result.recognizedWords;
        QueryResult query = await dialogflow.response(lastWords);
        speak(query.fulfillmentText);
        widget.provider.intent = query.intent.displayName;
        widget.provider.queryResult = query;
        oneTime = false;
      }
    }
  }

  startListening()  {
     speech.listen(
        onResult: resultListener,
        localeId: _currentLocaleId,
        pauseFor: Duration(seconds: 3),
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true,
        onDevice: true,
        listenMode: ListenMode.confirmation);

  }

  soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel,level);
    maxSoundLevel = max(maxSoundLevel,level);
  }
}
