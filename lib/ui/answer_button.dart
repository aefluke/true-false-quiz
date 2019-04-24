import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final bool _answer;
  final VoidCallback _onTap;

  AnswerButton(this._answer, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: _answer ? Colors.greenAccent : Colors.redAccent,
        child: InkWell(
          onTap: () => _onTap(),
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5)),
                padding: EdgeInsets.all(20),
                child: Text(
                  _answer ? "Doğru" : "Yanlış",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )),
          ),
        ),
      ),
    );
  }
}
