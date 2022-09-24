import 'package:flutter/material.dart';
import 'package:guessnumber3/game.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guessnumber3/util/helper.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({Key? key}) : super(key: key);

  @override
  _GuessPageState createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {

  var _input = '';
  var _message = '';
  var _game = Game();
  var _click = false;

  void _handleClickButton(int num) {
    setState(() {
      if (num == -1) {
        if (_input.length > 0) {
          _input = _input.substring(0, _input.length - 1);
        }
      }
      else if (num == -2) {
        if (_input.length > 0) {
          _input = _input.substring(0, _input.length - _input.length);
        }
      }
      else {
        if (_input.length < 3) {
          if (num != -3) {
            _input = _input + num.toString();
          }
          else {
            _input = _input;
          }
        }
      }
    });

    if (_input.length == '') {
      showMyDialog(context, 'ERROR', 'กรุณากรอกตัวเลข');
      setState(() {
        _input = '';
      });
    }
  }

  Widget _buildNumberButton(int num){
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: InkWell(
          onTap: () {
            setState(() {
              _handleClickButton(num);
            });
          },
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            width: 60.0,
            height: 30.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Color(0x200191231),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
              child: num == -1
                  ? Icon(Icons.backspace_outlined, color: Colors.purple,)
                  :num == -2 ? Icon(IconData(0xef58, fontFamily: 'MaterialIcons'), color: Colors.purple,)
                  : Text(
                num.toString(),
                style: GoogleFonts.roboto(
                  color: Colors.purple,
                  fontSize: 20.0,
                ),
              ),
          ),
        ),
    );
  }
  void handleClickGuess(){
    _click = true;
    var guess = int.tryParse(_input)!;
    var result = _game.doGuess(guess);
    var round = _game.guessCount;
    if(result == Result.tooHigh){
      _message = '$guess : มากเกินไป';
      _handleClickButton(-2);
    }
    else if(result == Result.tooLow){
      _message = '$guess : น้อยเกินไป';
      _handleClickButton(-2);
    }
    else{
      _message = '$guess : ถูกต้อง \u{1F389} (ทาย $round ครั้ง)';
      _handleClickButton(-3);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUESS THE NUMBER',
          style: GoogleFonts.roboto(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0
          ),
          decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              border: Border.all(
                width: 5.0,
                color: Color(0xFFF3E5F5),
              ),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0,3),
                )
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/guess_logo.png',
                    width: 100.0,
                  ),
                  SizedBox(width: 10.0,),
                  Column(
                    children: [
                      Text('GUESS',
                        style: GoogleFonts.roboto(
                          fontSize: 40.0,
                          color: Color(0xFFD292DC),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text('THE NUMBER',
                        style: GoogleFonts.roboto(
                          fontSize: 20.0,
                          color: Color(0xFF6B2983),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_input,
                      style: GoogleFonts.roboto(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(_click
                      ? _message
                      : 'ทายเลข 1 ถึง 100',
                    style: GoogleFonts.kanit(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  for (var row in [
                    [1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9]
                  ])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i in row) _buildNumberButton(i),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNumberButton(-2),
                      _buildNumberButton(0),
                      _buildNumberButton(-1),
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: handleClickGuess,
                        child: Text('GUESS'),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
