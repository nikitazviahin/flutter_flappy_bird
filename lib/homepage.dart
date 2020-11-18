import 'dart:async';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';
import 'package:flappy_bird/barrier.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //variables for physics and moves of the bird
  static double birdYaxis = 0;
  double initialHeight = birdYaxis;
  double time = 0;
  double height = 0;
  double timeChangeRate = 0.007;
  //to manage the status of the game
  bool gameHasStarted = false;

  //simulation of gravity
  double gravityFunction (time) => -4.9 * time * time + 3 * time;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      time += timeChangeRate;
      height = gravityFunction(time);
      setState(() {
       birdYaxis = initialHeight - height;
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (gameHasStarted) {
                      jump();
                    } else {
                      startGame();
                    }
                  },
                  child: AnimatedContainer(
                    alignment: Alignment(0,birdYaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue, 
                    child: MyBird(),
                  ),
                ),
                Container(
                  alignment: Alignment(0, -0.3),
                  child: gameHasStarted ? Text(' ') : Text(
                      'TAP TO PLAY',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                  ),
                ),
                MyBarrier(
                  size: 200.0,
                ),
              ],
            ),
            ),
            Container(
              height: 15.0,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SCORE',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        '0',
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'BEST',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        '10',
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}