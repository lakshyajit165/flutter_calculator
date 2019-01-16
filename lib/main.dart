import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String output = "0";

  String exp = "";//new

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText){
      if(buttonText == "CLEAR"){
            _output = "0";
           num1 = 0.0;
             num2 = 0.0;
             operand = "";
             exp = ""; //new
      }else if(buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/"){

        num1 = double.parse(output);

        operand = buttonText;
  
        _output = "0";

        exp += buttonText; //new

      }else if(buttonText == "."){
        if(_output.contains(".")){
          //print("Already contains a decimal");
          Fluttertoast.showToast(
            
            msg: "Already contains a decimal",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
            backgroundColor: Colors.black87,
            textColor: Colors.white

          );
          
          return;
        }else{
          _output = _output + buttonText;
          exp += buttonText; //new
        }
      
      }else if(buttonText == "="){
        num2 = double.parse(output);

        if(operand == "+"){
          _output = (num1 + num2).toString();
          exp = double.parse(_output).toStringAsFixed(2); //new
        }

        if(operand == "-"){
          _output = (num1 - num2).toString();
          exp = double.parse(_output).toStringAsFixed(2); //new
        }

        if(operand == "x"){
          _output = (num1 * num2).toString();
          exp = double.parse(_output).toStringAsFixed(2); //new
        }

        if(operand == "/"){
          _output = (num1 / num2).toString();
          exp = double.parse(_output).toStringAsFixed(2); //new
        }

        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      
      }else{
        _output = _output + buttonText;
        exp += buttonText;
      }
    print(_output);

    setState(() {
          
      output = double.parse(_output).toStringAsFixed(2);

    });
  }

  Widget buildButton(String buttonText) {
    return new Expanded(
      child: new OutlineButton(
        padding: new EdgeInsets.all(24.0),
        child: new Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            new Container(
                alignment: Alignment.centerRight,
                padding:
                    new EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
                child: new Text(output,
                    style: new TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ))),
             new Expanded(
              child: new Divider(),
            ),

             new Container(
                alignment: Alignment.centerRight,
                padding:
                    new EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                child: new Text(exp,
                    style: new TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ))),
            new Column(children: [
              new Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/")
              ]),
              new Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("x")
              ]),
              new Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-")
              ]),
              new Row(children: [
                buildButton("."),
                buildButton("0"),
                buildButton("00"),
                buildButton("+")
              ]),
              new Row(children: [buildButton("CLEAR"), buildButton("=")]),
            ])
          ],
        )));
  }
}
