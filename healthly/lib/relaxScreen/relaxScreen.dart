import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';

const img = 'assets/images/';
const title = TextStyle(
    color: Colors.white,
    fontSize: 36,
    letterSpacing: 13.0,
    fontWeight: FontWeight.w600);

class HomeRoute extends StatelessWidget {
  row(s1, s2, context) {
    return Wrap(
      children: [
        soundBtn(s1, context),
        soundBtn(s2, context),
      ],
    );
  }

  soundBtn(sound, context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PlayRoute(sound: sound)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20.0,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Image.asset('assets/icons/$sound.png'),
              Text(sound.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, letterSpacing: 3.0)),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  @override
  build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Stressed?',
                    style: title.copyWith(fontFamily: "QuickSand"),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tap any icon below.',
                    style: TextStyle(
                        fontFamily: "QuickSand",
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 25),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            img + 'bkgnd_2.png',
                          ),
                          fit: BoxFit.contain),
                    ),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Wrap(
                    children: [
                      soundBtn("rain", context),
                      soundBtn("sunset", context),
                      soundBtn("forest", context),
                      soundBtn("ocean", context),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlayRoute extends StatefulWidget {
  final String sound;
  const PlayRoute({Key key, this.sound}) : super(key: key);
  @override
  _PlayRouteState createState() => _PlayRouteState();
}

class _PlayRouteState extends State<PlayRoute> {
  AudioPlayer player;
  AudioCache cache;
  bool initialPlay = true;
  bool playing;

  @override
  initState() {
    super.initState();
    player = new AudioPlayer();
    cache = new AudioCache(fixedPlayer: player);
  }

  @override
  dispose() {
    super.dispose();
    player.stop();
  }

  playPause(sound) {
    if (initialPlay) {
      cache.play('audio/$sound.mp3');
      playing = true;
      initialPlay = false;
    }
    return IconButton(
      color: Colors.white70,
      iconSize: 80.0,
      icon: playing
          ? Icon(Icons.pause_circle_filled)
          : Icon(Icons.play_circle_filled),
      onPressed: () {
        setState(() {
          if (playing) {
            playing = false;
            player.pause();
          } else {
            playing = true;
            player.resume();
          }
        });
      },
    );
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 0, left: 0, child: Background(sound: widget.sound)),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(backgroundColor: Colors.transparent, elevation: 0)),
          Padding(
              padding: const EdgeInsets.only(top: 180.0),
              child: Center(
                  child: Column(children: [
                Text(widget.sound.toUpperCase(),
                    style: title.copyWith(fontFamily: "QuickSand")),
                playPause(widget.sound)
              ]))),
        ],
      ),
    );
  }
}

class Background extends StatefulWidget {
  final String sound;
  const Background({Key key, this.sound}) : super(key: key);
  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  Timer timer;
  bool _visible = false;

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  swap() {
    if (mounted) {
      setState(() {
        _visible = !_visible;
      });
    }
  }

  @override
  build(BuildContext context) {
    timer = Timer(Duration(seconds: 6), swap);
    return Stack(
      children: [
        Image.asset(img + widget.sound + '_1.jpg'),
        AnimatedOpacity(
            child: Image.asset(img + widget.sound + '_2.jpg'),
            duration: Duration(seconds: 2),
            opacity: _visible ? 1.0 : 0.0)
      ],
    );
  }
}
