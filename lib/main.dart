// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
      ),
      home: Calculator(),
    );
  } 
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  Widget calcButton(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: btncolor,
          fixedSize: Size(85, 85),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(5)),
      child: Text(
        btntxt,
        style: TextStyle(
          fontSize: 35,
          color: txtcolor,
        ),
      ),
    );
  }
  Widget calcButtonforzero(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: btncolor,
          fixedSize: Size(185, 85),
          padding: const EdgeInsets.all(5)),
      child: Text(
        btntxt,
        style: TextStyle(
          fontSize: 35,
          color: txtcolor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Calculator'),backgroundColor: Colors.black,),
      body:  Padding(padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(padding: EdgeInsets.all(10.0),
                  child: Text(text,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white,fontSize: 100),
                
                ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC',Colors.grey,Colors.black),
                calcButton('+/-',Colors.grey,Colors.black),
                calcButton('%',Colors.grey,Colors.black),
                calcButton('÷',const Color.fromARGB(255, 240, 152, 0),Colors.white),
                //Functions
            ],),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7',Colors.grey[850]!,Colors.white),
                calcButton('8',Colors.grey[850]!,Colors.white),
                calcButton('9',Colors.grey[850]!,Colors.white),
                calcButton('x',Colors.amber[700]!,Colors.white),
                //Functions
            ],),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4',Colors.grey[850]!,Colors.white),
                calcButton('5',Colors.grey[850]!,Colors.white),
                calcButton('6',Colors.grey[850]!,Colors.white),
                calcButton('-',Colors.amber[700]!,Colors.white),
                //Functions
            ],),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1',Colors.grey[850]!,Colors.white),
                calcButton('2',Colors.grey[850]!,Colors.white),
                calcButton('3',Colors.grey[850]!,Colors.white),
                calcButton('+',Colors.amber[700]!,Colors.white),
                //Functions
            ],),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButtonforzero('0',Colors.grey[850]!,Colors.white),
                calcButton('.',Colors.grey[850]!,Colors.white),
                calcButton('=',Colors.amber[700]!,Colors.white),
                //Functions
            ],),
            const SizedBox(height: 10,),

          ],
        ),
      )

    );
  }
  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  dynamic resultWithOperator = '';
   void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      resultWithOperator = '';
      opr = '';
      preOpr = '';
    
    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
         finalResult = add();
      } else if( preOpr == '-') {
          finalResult = sub();
      } else if( preOpr == 'x') {
          finalResult = mul();
      } else if( preOpr == '÷') {
          finalResult = div();
      } 

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '÷' || btnText == '=') {

      if(numOne == 0) {
          numOne = double.parse(result);
      } else {
          numTwo = double.parse(result);
      }

      if(opr == '+') {
          finalResult = add();
      } else if( opr == '-') {
          finalResult = sub();
      } else if( opr == 'x') {
          finalResult = mul();
      } else if( opr == '/') {
          finalResult = div();
      } 
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
     result = numOne / 100;
     finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }
    
    else if(btnText == '+/-') {
        result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();        
        finalResult = result;        
    
    } 
    
    else {
        result = result + btnText;
        finalResult = result;        
    }


    setState(() {
          text = finalResult;
        });

  }


  String add() {
         result = (numOne + numTwo).toString();
         numOne = double.parse(result);        

         return doesContainDecimal(result);
  }

  String sub() {
         result = (numOne - numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String mul() {
         result = (numOne * numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String div() {
          result = (numOne / numTwo).toString();
          numOne = double.parse(result);
          return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {
    
    if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return result = splitDecimal[0].toString();
    }
    return result; 
  }


}