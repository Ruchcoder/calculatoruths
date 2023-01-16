import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const CalculatorApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class CalculatorApp extends StatefulWidget {
  const CalculatorApp ({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();


}

class _CalculatorAppState extends State<CalculatorApp> {

  String userInput = "";
  String result = "0";

  List<String> buttonsList = [
    "c",
    "(",
    ")",
    "x",
    "7",
    "8",
    "9",
    "-",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "/",
    "0",
    ".",
    "AC",
    "=",
  ];



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF84FFFF),
        appBar:AppBar(title: Text("Calculator",),backgroundColor:
        Color(0xFF26C6DA),),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(child: resultWidget(),flex: 1,),
            Flexible(child: buttonWidget(),flex: 2,),
            

          ],
        ),
      ),

    );
  }

  Widget resultWidget(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(25.0),
          alignment: Alignment.centerLeft,
          child: Text(
            userInput,
          style: TextStyle(fontSize: 42),
          ),
        ),

        Container(
          padding: EdgeInsets.all(15.0),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: TextStyle(fontSize: 29),
          ),
        ),
        
      ],
    );
    


  }

  Widget buttonWidget(){
    return GridView.builder(
      itemCount: buttonsList.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return button(buttonsList[index]);
      }
    );

  }
  Widget button(String text){
    return Container(
      margin: EdgeInsets.all(7),

      child: MaterialButton(
        onPressed:(){
          setState(() {
            handleButtonPress(text);
          });

      },
        color: getColor(text),
        textColor: Colors.black45,
        child: Text(text,
        style: TextStyle(
          fontSize: 27
        ),
        ),
        shape: CircleBorder(),
      ),
    );


  }


  handleButtonPress(String text){

    //reset all
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }

    if(text == "c"){
      //Remove last character
      userInput = userInput.substring(0,userInput.length-1);
      return;
    }
    if(text == "="){
      //Calculate the result
      result= calculate();
      //REMOVE DECIMAL IF .0
      if(result.endsWith(".0"))result = result.replaceAll(".0", "");
      return;

    }

userInput = userInput + text;

  }
  String calculate(){
    try {
      var exp = Parser().parse(userInput);
      var evaluation =  exp.evaluate(EvaluationType.REAL,
          ContextModel());
      return evaluation.toString();

    }catch(e){
      return "error";
    }

  }

  getColor(String text) {
    if(text =="c"){
      return Colors.purpleAccent;
    }
    if (text == "(" || text == ")" )
    {
      return Colors. cyan;
    }

    if(text =="-" || text == "+" || text == "/" || text== "x"){
      return Colors.black54;
    }

    if(text == "="){
      return Colors.indigo;
    }
    if(text == "AC"){
      return Colors.white;
    }

    return Colors.deepPurple;
  }

}



