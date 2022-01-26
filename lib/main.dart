// @dart=2.10

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List winners = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 4, 8],
    [2, 4, 6],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ];
  List moves = [];
  List x_moves = [];

  List o_moves = [];

  bool switchPlayer = false;

  String text(int index) {
    if (x_moves.contains(index)) {
      return "X";
    } else if (o_moves.contains(index)) {
      return "O";
    } else {
      return "";
    }
  }

  String result = "";

  void win() {
    for (var win in winners) {
      if (x_moves.contains(win[0]) &&
          x_moves.contains(win[1]) &&
          x_moves.contains(win[2])) {
        setState(() {
          result = "X utdy";
        });
      } else if (o_moves.contains(win[0]) &&
          o_moves.contains(win[1]) &&
          o_moves.contains(win[2])) {
        setState(() {
          result = "O utdy";
        });
      } else if (result == "" && moves.length == 9) {
        result = "Deňlik";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              child: GridView.builder(
                itemCount: 9,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1,
                    mainAxisExtent: 120,
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        !moves.contains(index)
                            ? switchPlayer = !switchPlayer
                            : null;
                        switchPlayer
                            ? !o_moves.contains(index) && !moves.contains(index)
                                ? o_moves.add(index)
                                : null
                            : !x_moves.contains(index) && !moves.contains(index)
                                ? x_moves.add(index)
                                : null;
                        moves.contains(index) ? null : moves.add(index);
                        win();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 1.0, color: Colors.blue[200]),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                        child: Text(
                          text(index),
                          style: const TextStyle(
                              fontSize: 35, color: Colors.black54),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              result,
              style: const TextStyle(color: Colors.red, fontSize: 25),
            ),
            const SizedBox(height: 10),
            result != ""
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        moves.clear();
                        x_moves.clear();
                        o_moves.clear();
                        result = "";
                      });
                    },
                    child: const Text(
                      "Täzeden başla",
                      style: TextStyle(color: Colors.red, fontSize: 25),
                    ),
                  )
                : Container(height: 49)
          ],
        ),
      ),
    );
  }
}
