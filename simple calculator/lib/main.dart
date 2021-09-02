import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: SafeArea(child: Calculator()),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  buttonfunc(value) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueGrey[400],
      ),
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(20),
      child: Center(
          child: Text(
        '$value',
        style: TextStyle(fontSize: 40, color: Colors.brown[100]),
      )),
    );
  }

  circle_button(String function, String result_value) {
    return FlatButton(
        child: buttonfunc(function),
        onPressed: () {
          setState(() {
            result += result_value;
          });
        });
  }

  mainchar(String char) {
    if (result[result.length - 1] == "/" || result[result.length - 1] == "*" || result[result.length - 1] == "+" || result[result.length - 1] == "-") {
      setState(() {
        result = result.substring(0, result.length - 1);
        result += '$char';
        print(result);
      });
    } else if (result[result.length - 1] != "/" || result[result.length - 1] != "*" || result[result.length - 1] != "+" || result[result.length - 1] != "-") {
      setState(() {
        result += '$char';
        print(result);
      });
    }
  }

  dynamic result = "";
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Expanded(
        flex: 2,
        child: Container(
          alignment: Alignment.bottomRight,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadiusDirectional.circular(7.0),
            color: Colors.blueGrey[400],
          ),
          margin: EdgeInsets.all(12),
          child: Wrap(
            children: [
              Container(margin: EdgeInsets.fromLTRB(10, 10, 19, 10), child: Text('$result', style: TextStyle(fontSize: 40)))
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
            child: Row(children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Expanded(child: circle_button("7", "7")),
          Expanded(child: circle_button("8", "8")),
          Expanded(child: circle_button("9", "9")),
          Expanded(
              child: FlatButton(
                  child: buttonfunc("+"),
                  onPressed: () {
                    setState(() {
                      mainchar("+");
                    });
                  })),
          SizedBox(
            width: 10,
          ),
        ])),
      ),
      Expanded(
          flex: 1,
          child: Container(
              child: Row(children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Expanded(child: circle_button("4", "4")),
            Expanded(child: circle_button("5", "5")),
            Expanded(child: circle_button("6", "6")),
            Expanded(
                child: FlatButton(
                    child: buttonfunc("-"),
                    onPressed: () {
                      setState(() {
                        mainchar("-");
                      });
                    })),
            SizedBox(
              width: 10,
            ),
          ]))),
      Expanded(
        flex: 1,
        child: Container(
            child: Row(children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Expanded(child: circle_button("1", "1")),
          Expanded(child: circle_button("2", "2")),
          Expanded(child: circle_button("3", "3")),
          Expanded(
              child: FlatButton(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: Text(
                      'CE',
                      style: TextStyle(fontSize: 25, color: Colors.blueGrey[800]),
                    )),
                  ),
                  onPressed: () {
                    setState(() {
                      result = "";
                    });
                  })),
          SizedBox(
            width: 10,
          ),
        ])),
      ),
      Expanded(
        flex: 1,
        child: Container(
            child: Row(children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: FlatButton(
                  child: buttonfunc("/"),
                  onPressed: () {
                    setState(() {
                      mainchar("/");
                    });
                  })),
          Expanded(child: circle_button("0", "0")),
          Expanded(
              child: FlatButton(
                  child: buttonfunc("*"),
                  onPressed: () {
                    setState(() {
                      mainchar("*");
                    });
                  })),
          Expanded(
              child: FlatButton(
                  child: buttonfunc("="),
                  onPressed: () {
                    setState(() {
                      Parser p = Parser();
                      Expression exp = p.parse(result);
                      ContextModel cm = ContextModel();
                      double eval = exp.evaluate(EvaluationType.REAL, cm);
                      result = eval.toString();
                    });
                  })),
          SizedBox(
            width: 10,
          ),
        ])),
      ),
      SizedBox(
        height: 10,
      )
    ]));
  }
}
