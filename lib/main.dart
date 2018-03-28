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

  String outputString = "2 x 3 = 4";
  double l_value;
  double r_value;
  double result;
  String mat_op;

  void inputHandler(String buttonValue){

    setState(() {

      if (outputString.contains("=")) {
        outputString = "";
      }

      switch(buttonValue) {
        case "C":
          outputString = "";
          break;
        case "<":
          if (outputString.length > 1){
            String _inputString = outputString.substring(0, outputString.length - 2);
            outputString = _inputString;
          }
          break;
        case ".":
          outputString = outputString.substring(0, outputString.length - 1);
          outputString += ".";
          break;
        case "=":

          if(outputString[outputString.length -1 ] == " "){
            outputString = outputString.substring(0, outputString.length - 1);
          }


          List<String> components = outputString.split(" ");

          if(components.length != 3) {
            outputString = "Nicht unterstützt";
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
              if (r_value != 0.0){
                result = l_value / r_value;
              } else {
                result = 13.37;
              }
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
            outputString += " = " + result.round().toString();
          } else {
            outputString += " = " + result.toString();
          }

          // } catch (e, stackTrace) {
          //   print(e);
          //   print(stackTrace);
          //   outputString = "Ungültiges Format";
          // }

          break;
        default:
          outputString += buttonValue + " ";
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
                    new Expanded (
                      child : new SingleChildScrollView (
                        scrollDirection: Axis.horizontal,
                        child : new Text(
                          outputString,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          softWrap: true,
                          style: new TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 40.0,
                            ),
                          ),
                        ),
                      ),
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


