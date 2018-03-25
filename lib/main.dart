import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Calculator",
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blueGrey,
          ),
        home: new Calculator(),
        );
  }
}

class Calculator extends StatefulWidget {
  @override
  CalcState createState() => new CalcState();
}

class CalcState extends State<Calculator> {

  String inputString = "2 x 3 = 4";
  double l_value;
  double r_value;
  double result;
  String mat_op;

  void inputHandler(String buttonValue){

    setState(() {

      if (inputString.contains("=")) {
        inputString = "";
      }

      switch(buttonValue) {
        case "C":
          inputString = "";
          break;
        case "<":
          if (inputString.length > 1){
            String _inputString = inputString.substring(0, inputString.length - 2);
            inputString = _inputString;
          }
          break;
        case ".":
          inputString = inputString.substring(0, inputString.length - 1);
          inputString += ".";
          break;
        case "=":

          if(inputString[inputString.length -1 ] == " "){
            inputString = inputString.substring(0, inputString.length - 1);
          }


          List<String> components = inputString.split(" ");

          if(components.length != 3) {
            inputString = "Nicht unterstützt";
          }

          print(components);

          // try {
            l_value = double.parse(components[0]);
            r_value = double.parse(components[2]);
            print("Left Value: " + l_value.toString());
            print("Right Value: " + r_value.toString());

            mat_op = components[1];
            print("Operator: " + mat_op);

            switch(mat_op) {
              case "%":
                result = l_value % r_value;
                break;
              case "/":
                result = l_value / r_value;
                break;
              case "x":
                result = l_value * r_value;
                break;
              case "-":
                result = l_value - r_value;
                break;
              case "+":
                result = l_value + r_value;
                break;
            }

            print("Result: " + result.toString());

            if(result == result.round()) {
              inputString += " = " + result.round().toString();
            } else {
              inputString += " = " + result.toString();
            }

          // } catch (e, stackTrace) {
          //   print(e);
          //   print(stackTrace);
          //   inputString = "Ungültiges Format";
          // }

          break;
        default:
          inputString += buttonValue + " ";
          break;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Calculator"),
          ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                color: Colors.white.withOpacity(0.85),
                child: new Row(
                  children: <Widget>[
                    new Text(
                      inputString,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      softWrap: true,
                      style: new TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 40.0,
                        ),
                      )
                  ],
                  ),
                ),
              ),
            new Expanded(
                flex: 4,
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      makeBtns('C<%/'),
                      makeBtns('789x'),
                      makeBtns('456-'),
                      makeBtns('123+'),
                      makeBtns('0.='),
                    ],
                    ),
                  ),
                )
              ],
              ),
              );
  }

  Widget makeBtns(String row) {
    List<String> token = row.split("");
    return new Expanded(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: token
          .map((e) => new Expanded(
              flex : 1,
              child : new FlatButton(
                color : Colors.white,
                child : new Text (
                  e == '_' ? "+/-" : e == '<' ? '<=' : e,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 36.0,
                    color: Colors.black54,
                    fontStyle: FontStyle.normal,
                    ),
                  ),
                onPressed: () => inputHandler(e),
                ),
              )
            )
          .toList(),
    ),
    );
  }
}


