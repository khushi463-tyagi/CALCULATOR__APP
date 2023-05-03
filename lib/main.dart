import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(const MaterialApp(
    home: CalculatorApp(),

  )
  );
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var input= '';
  var output= '';
  var operation= '';
  var hideinput=false;
  var outputsize=34.0;

  onButtonClick(value)
  {
    if(value =="AC")
      {
        input="";
        output="";
      }
    else if(value=="⌫")
      {
        if(input.isNotEmpty)
          {
            input=input.substring(0,input.length-1);
          }
      }
    else if(value=="=")
      {
        if(input.isNotEmpty)
          {
            var userinput=input;
            userinput=input.replaceAll("x","*");
            Parser p=Parser();
            Expression expression=p.parse(userinput);
            ContextModel cm=ContextModel();
            var finalvalue= expression.evaluate(EvaluationType.REAL, cm);
            output=finalvalue.toString();
            if(output.endsWith(".0"))
              {
                output=output.substring(0,output.length-2);
              }
            input=output;
            hideinput=true;
            outputsize=52;
          }
      }

    else
    {
        input=input+value;
        hideinput=false;
        outputsize=30;
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Calculator"),),
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.grey[850],
      body: Column(
        children: [
          Expanded(child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideinput ? '':input,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(
                height: 20,
                ),

                Text(
                  output,
                  style: TextStyle(
                    fontSize: outputsize,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
          ),
          Row(
            children: [
              button(text: "AC",buttonBgColor: Colors.redAccent),
              button(text: "⌫",buttonBgColor: Colors.redAccent),
              button(text: "^",buttonBgColor:Colors.indigo),
              button(text:"/",buttonBgColor:Colors.indigo),
            ],
          ),

          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x",buttonBgColor:Colors.indigo),
            ],
          ),

          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-",buttonBgColor:Colors.indigo),
            ],
          ),

          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3",),
              button(text: "+",buttonBgColor:Colors.indigo),
            ],
          ),


          Row(
            children: [
              button(text: "."),
              button(text: "0"),
              button(text: "00",),
              button(text: "=",buttonBgColor: Colors.redAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text,tColor=Colors.white,buttonBgColor=Colors.orange})
  {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(17),
              backgroundColor: buttonBgColor,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(300.0)
              ),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(text,
            style: TextStyle(
            fontSize: 28,
            color: tColor,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
      ),
    );
  }
}
