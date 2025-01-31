import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const Game());
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GameHome(),
      title: "JokenPo",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(65, 67, 97, 1),
        fontFamily: "ABeeZee",
      ),
    );
  }
}

class GameHome extends StatefulWidget {
  const GameHome({super.key});

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<GameHome> {
  final Map<String, List<String>> rules = {
    "Rock": ["Scissors", "Lizard"],
    "Paper": ["Rock", "Spock"],
    "Scissors": ["Paper", "Lizard"],
    "Lizard": ["Spock", "Paper"],
    "Spock": ["Scissors", "Rock"],
  };

  final List<String> _options = [
    "Rock",
    "Paper",
    "Scissors",
    "Lizard",
    "Spock"
  ];

  String _userChoice = "";
  String _appChoice = "";
  String _result = "";
  String _imageApp = "images/default_icon.png";

  void _play(String choise) {
    setState(() {
      _userChoice = choise;
      _appChoice = _options[Random().nextInt(5)]; // ou nextInt(_options.lenght)
      _imageApp = "images/${_appChoice.toLowerCase()}_icon.png";

      if (_userChoice == _appChoice) {
        _result = "Empatou!";
      } else if (rules[_userChoice]!.contains(_appChoice)) {
        _result = "Você ganhou!";
      } else {
        _result = "Você perdeu!";
      }
      _showResult();
    });
  }

  Widget _button(String choice, String images) {
    return GestureDetector(
      onTap: () => _play(choice),
      child: Column(
        children: [
          Image.asset(
            images,
            width: 90,
            height: 90,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            choice,
            style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(250, 201, 184, 1),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  void _showResult() {
    final snackBar = SnackBar(
      content: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _result,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      )),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.redAccent.shade200,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 70,
            backgroundColor: const Color.fromARGB(255, 83, 78, 99),
            title: Text(
              "JokenPo 2.0 : Lagarto e Spock",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(250, 201, 184, 1)),
            )),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "Opção escolhida pelo App: ",
            style: TextStyle(
                fontSize: 25,
                color: Color.fromRGBO(255, 198, 137, 1),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            _imageApp,
            width: 110,
            height: 110,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Escolha uma opção: ",
            style: TextStyle(
                fontSize: 25,
                color: Color.fromRGBO(255, 198, 137, 1),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _button("Rock", "images/rock_icon.png"),
              _button("Paper", "images/paper_icon.png"),
              _button("Scissors", "images/scissors_icon.png"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _button("Lizard", "images/lizard_icon.png"),
              _button("Spock", "images/spock_icon.png"),
            ],
          ),
        ]));
  }
}
