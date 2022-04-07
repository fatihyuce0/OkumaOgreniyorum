import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    renk1=Colors.black;
    renk2=Colors.black;
    renk3=Colors.black;
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      var arr = _lastWords.split(' ');
      if(arr[0]=="Ali"){
        renk1=Colors.green;
      }
      else{
        renk1=Colors.red;
      }
      if(arr[1]=="yavaş"){
        renk2=Colors.green;
      }
      else{
        renk2=Colors.red;
      }
      if(arr[2]=="koş"){
        renk3=Colors.green;
      }
      else{
        renk3=Colors.red;
      }


    });
  }
var renk=Colors.purple;
  var renk1=Colors.black;
  var renk2=Colors.black;
  var renk3=Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mühendislik Tasarımı'),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Okunacak cümle:',
                style: TextStyle(fontSize: 20.0,color: Colors.orange),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child:Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("ALİ", style: TextStyle(fontSize: 35.0,color: renk1),),
                  Text("YAVAŞ", style: TextStyle(fontSize: 35.0,color: renk2),),
                  Text("KOŞ", style: TextStyle(fontSize: 35.0,color: renk3),),
                ],
              )
            ),
           Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  // If listening is active show the recognized words
                  _speechToText.isListening
                      ? 'Dinleniyor...'
                  // If listening isn't active but could be tell the user
                  // how to start it, otherwise indicate that speech
                  // recognition is not yet ready or not supported on
                  // the target device
                      : _speechEnabled
                      ? 'Konuşmak için mikrofona basın...'
                      : 'Speech not available',
                ),
              ),

          Container(
                padding: EdgeInsets.all(16),
                child: Text("$_lastWords"


                ),
              ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
        // If not yet listening for speech start, otherwise stop
        _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}