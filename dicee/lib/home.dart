import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'Dicee',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RollDice(),
    );
  }
}

final random = Random();

class RollDice extends StatefulWidget {
  RollDice({
    super.key,
  });

  @override
  State<RollDice> createState() => _RollDiceState();
}

class _RollDiceState extends State<RollDice> {
  int dice1 = 1;
  int dice2 = 1;

  void rollDice() {
    setState(() {
      dice1 = random.nextInt(6) + 1;
      dice2 = random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 60),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Example',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          rollDice();
                        },
                        child: Image.asset('images/dice$dice1.png'))),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          rollDice();
                        },
                        child: Image.asset('images/dice$dice2.png'))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  rollDice();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    'Roll Dice',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
