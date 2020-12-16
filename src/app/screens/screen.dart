import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../helpers/http_helper.dart';

class ScreenLight extends StatefulWidget {
  @override
  _ScreenLightState createState() => _ScreenLightState();
}

class _ScreenLightState extends State<ScreenLight> {
  bool _led1 = false;
  bool _led2 = false;
  bool _led3 = false;
  bool _sequenceRunning = false;

  void _toggleLED(int ledNumber) async {
    int resp = 1;
    switch (ledNumber) {
      case 1:
        resp = await HTTP.espLed(1, !_led1);
        break;
      case 2:
        resp = await HTTP.espLed(2, !_led2);
        break;
      case 3:
        resp = await HTTP.espLed(3, !_led3);
        break;
      default:
        return;
    }
    if (resp != 0) {
      return;
    }
    setState(
      () {
        if (ledNumber == 1) {
          _led1 = !_led1;
        } else if (ledNumber == 2) {
          _led2 = !_led2;
        } else {
          _led3 = !_led3;
        }
      },
    );
  }

  void _toggleSequence() async {
    int resp = 1;
    setState(() {
      _sequenceRunning = true;
    });
    resp = await HTTP.espSequence();
    if (resp == 0) {
      setState(() {
        _sequenceRunning = false;
        _led1 = false;
        _led2 = false;
        _led3 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ovládání LED"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 30,
                ),
                width: 250,
                height: 100,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (_) {
                        return _led1
                            ? Theme.of(context).accentColor
                            : Colors.white;
                      },
                    ),
                    shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (_) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        );
                      },
                    ),
                    side: MaterialStateProperty.resolveWith(
                      (states) {
                        Color _borderColor;
                        if (states.contains(MaterialState.pressed)) {
                          _borderColor = Colors.red;
                        } else {
                          _borderColor = Colors.deepPurple;
                        }
                        return BorderSide(color: _borderColor, width: 5);
                      },
                    ),
                  ),
                  child: Text(
                    "LED 1",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  onPressed: () => {_toggleLED(1)},
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 30,
                ),
                width: 250,
                height: 100,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (_) {
                        return _led2
                            ? Theme.of(context).accentColor
                            : Colors.white;
                      },
                    ),
                    shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (_) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        );
                      },
                    ),
                    side: MaterialStateProperty.resolveWith(
                      (states) {
                        Color _borderColor;
                        if (states.contains(MaterialState.pressed)) {
                          _borderColor = Colors.red;
                        } else {
                          _borderColor = Colors.deepPurple;
                        }
                        return BorderSide(color: _borderColor, width: 5);
                      },
                    ),
                  ),
                  child: Text(
                    "LED 2",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  onPressed: () => {_toggleLED(2)},
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 30,
                ),
                width: 250,
                height: 100,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (_) {
                        return _led3
                            ? Theme.of(context).accentColor
                            : Colors.white;
                      },
                    ),
                    shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (_) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        );
                      },
                    ),
                    side: MaterialStateProperty.resolveWith(
                      (states) {
                        Color _borderColor;
                        if (states.contains(MaterialState.pressed)) {
                          _borderColor = Colors.red;
                        } else {
                          _borderColor = Colors.deepPurple;
                        }
                        return BorderSide(color: _borderColor, width: 5);
                      },
                    ),
                  ),
                  child: Text(
                    "LED 3",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  onPressed: () => {_toggleLED(3)},
                ),
              ),
              _sequenceRunning
                  ? Container(
                      margin: EdgeInsets.only(
                        top: 50,
                      ),
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 30,
                      ),
                      width: 250,
                      height: 100,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (_) {
                              return Colors.white;
                            },
                          ),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (_) {
                              return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              );
                            },
                          ),
                          side: MaterialStateProperty.resolveWith(
                            (states) {
                              Color _borderColor;
                              if (states.contains(MaterialState.pressed)) {
                                _borderColor = Colors.red;
                              } else {
                                _borderColor = Colors.deepPurple;
                              }
                              return BorderSide(
                                color: _borderColor,
                                width: 5,
                              );
                            },
                          ),
                        ),
                        child: Text(
                          "SEQUENCE",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                        onPressed: _toggleSequence,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
