import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Xylophone extends StatefulWidget {
  @override
  _XylophoneState createState() => _XylophoneState();
}

class _XylophoneState extends State<Xylophone> {
  int current_dir = 1;

  final intTODir = {
    1: "standart_sounds",
    2: "gachi_sounds",
  };

  final intToColor = {
    1: Colors.red,
    2: Colors.orange,
    3: Colors.yellow,
    4: Colors.green,
    5: Colors.lightBlueAccent,
    6: Colors.blue,
    7: Colors.deepPurple,
  };

  static final AudioCache player = new AudioCache();

  @override
  Widget build(BuildContext context) {
    playNote(1);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              if (current_dir == 1)
                current_dir = 2;
              else
                current_dir = 1;
            },
            child: Icon(Icons.history),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child:
              ListView.builder(itemBuilder: (BuildContext context, int cindex) {
            if (cindex % 8 != 0)
              return makeButton((cindex) % 8, intToColor[(cindex) % 8]);
            else
              return SizedBox();
          }),
        ),
      ),
    );
  }

  void playNote(int n) {
    if (n == 7) {
      player.play('${intTODir[current_dir]}/note$n.mp3');
    } else {
      player.play('${intTODir[current_dir]}/note$n.wav');
    }
  }

  Widget makeButton(int note, Color color) {
    return GestureDetector(
      onTap: () {
        print('//////////////////');
        playNote(note);
      },
      child: Container(
        color: color,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 7,
      ),
    );
  }
}
