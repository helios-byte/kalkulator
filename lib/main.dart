import 'package:flutter/material.dart';
import 'calculator.dart';
import 'number-display.dart';
import 'calculator-buttons.dart';
import 'history.dart';

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
  MyHomePage({ Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isNewEquation = true;
  List<double> values = [];
  List<String> operations = [];
  List<String> calculations = [];
  String calculatorString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => _navigateAndDisplayHistory(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          NumberDisplay(value: calculatorString),
          CalculatorButtons(onTap: _onPressed),  // onTap menerima void Function(String)
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  _navigateAndDisplayHistory(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => History(operations: calculations)),
    );

    if (result != null) {
      setState(() {
        isNewEquation = false;
        calculatorString = Calculator.parseString(result);
      });
    }
  }

  void _onPressed(String buttonText) {
    if (Calculations.OPERATIONS.contains(buttonText)) {
      setState(() {
        operations.add(buttonText);
        calculatorString += " $buttonText ";
      });
      return;
    }

    if (buttonText == Calculations.CLEAR) {
      setState(() {
        operations.clear();
        calculatorString = "";
      });
      return;
    }

    if (buttonText == Calculations.EQUAL) {
      String newCalculatorString = Calculator.parseString(calculatorString);
      setState(() {
        if (newCalculatorString != calculatorString) {
          calculations.add(calculatorString);
        }
        operations.add(Calculations.EQUAL);
        calculatorString = newCalculatorString;
        isNewEquation = false;
      });
      return;
    }

    if (buttonText == Calculations.PERIOD) {
      setState(() {
        calculatorString = Calculator.addPeriod(calculatorString);
      });
      return;
    }

    setState(() {
      if (!isNewEquation && operations.last == Calculations.EQUAL) {
        calculatorString = buttonText;
        isNewEquation = true;
      } else {
        calculatorString += buttonText;
      }
    });
  }
}
