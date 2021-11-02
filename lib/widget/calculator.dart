import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  final TextEditingController txtController;
  final Function(String text) onChange;

  Calculator({required this.txtController, required this.onChange, Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String expression = "";
  String result = "0";
  bool isbool = true;
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  @override
  void initState() {
    if (widget.txtController.text.isEmpty) {
      equation = "0";
      expression = "";
    } else {
      equation = widget.txtController.text.trim();
      expression = widget.txtController.text.trim();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("%", 1, MyColors.calcuColor, 20),
                    buildButton("/", 1, MyColors.calcuColor, 20),
                    buildButton("×", 1, MyColors.calcuColor, 27),
                  ]),
                  TableRow(children: [
                    buildButton("1", 1, MyColors.calcuColor, 25),
                    buildButton("2", 1, MyColors.calcuColor, 25),
                    buildButton("3", 1, MyColors.calcuColor, 25),
                  ]),
                  TableRow(children: [
                    buildButton("4", 1, MyColors.calcuColor, 25),
                    buildButton("5", 1, MyColors.calcuColor, 25),
                    buildButton("6", 1, MyColors.calcuColor, 25),
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, MyColors.calcuColor, 25),
                    buildButton("8", 1, MyColors.calcuColor, 25),
                    buildButton("9", 1, MyColors.calcuColor, 25),
                  ]),
                  TableRow(children: [
                    buildButton(".", 1, MyColors.calcuColor, 25),
                    buildButton("0", 1, MyColors.calcuColor, 25),
                    buildButton("c", 1, MyColors.calcuColor, 25),
                  ]),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(children: [
                  TableRow(children: [
                    buildButton("⌫", 1, MyColors.calcuColor, 20),
                  ]),
                  TableRow(children: [
                    buildButton("-", 1, MyColors.calcuColor, 35),
                  ]),
                  TableRow(children: [
                    buildButton("+", 1, MyColors.calcuColor, 25),
                  ]),
                  TableRow(children: [
                    Center(child: buildButton("=", 2 * 1.02, MyColors.calcuColor, 40)),
                  ]),
                ]))
          ],
        ),
      ),
    );
  }

  buildButton(String buttonText, double buttonHeight, Color buttonColor, double buttonTexth) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.left,
        ),
        //**Alline height */
        //This is grate
        height: MediaQuery.of(context).size.height * 0.1 / 1.5 * buttonHeight + 2.4,

        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            MyColors.colorPrimary.withOpacity(.5),
            MyColors.colorPrimary.withOpacity(.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,

          //stops: [0.0,0.0]
        )),

        child: MaterialButton(
            onLongPress: () {
              if (buttonText == "⌫") {
                equation = "0";
                expression = "";
                widget.txtController.clear();
                widget.txtController.text = "0";
                widget.onChange(widget.txtController.text);
              }
              // buttonPressed(buttonText);
              // equation = "0";
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(color: MyColors.colorPrimary, width: 0.4, style: BorderStyle.solid)),
            padding: const EdgeInsets.all(0.0),
            onPressed: () => buttonPressed(buttonText),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: buttonTexth, fontWeight: FontWeight.normal, color: MyColors.textColor),
                ),
              ),
            )),
      ),
    );
  }

  buttonPressed(String buttonText) {
    if ((equation.substring(equation.length - 1) == "+" && buttonText == "+") ||
        (equation.substring(equation.length - 1) == "+" && buttonText == "-") ||
        (equation.substring(equation.length - 1) == "+" && buttonText == "×") ||
        (equation.substring(equation.length - 1) == "+" && buttonText == "/") ||
        (equation.substring(equation.length - 1) == "+" && buttonText == "=") ||
        (equation.substring(equation.length - 1) == "+" && buttonText == "%") ||
        (equation.substring(equation.length - 1) == "-" && buttonText == "-") ||
        (equation.substring(equation.length - 1) == "-" && buttonText == "+") ||
        (equation.substring(equation.length - 1) == "-" && buttonText == "×") ||
        (equation.substring(equation.length - 1) == "-" && buttonText == "/") ||
        (equation.substring(equation.length - 1) == "-" && buttonText == "=") ||
        (equation.substring(equation.length - 1) == "-" && buttonText == "%") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "×") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "+") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "-") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "/") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "=") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "%") ||
        (equation.substring(equation.length - 1) == "%" && buttonText == "%") ||
        (equation.substring(equation.length - 1) == "%" && buttonText == "+") ||
        (equation.substring(equation.length - 1) == "%" && buttonText == "-") ||
        (equation.substring(equation.length - 1) == "%" && buttonText == "/") ||
        (equation.substring(equation.length - 1) == "%" && buttonText == "=") ||
        (equation.substring(equation.length - 1) == "%" && buttonText == "×") ||
        (equation.substring(equation.length - 1) == "/" && buttonText == "×") ||
        (equation.substring(equation.length - 1) == "/" && buttonText == "+") ||
        (equation.substring(equation.length - 1) == "/" && buttonText == "-") ||
        (equation.substring(equation.length - 1) == "/" && buttonText == "/") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "×") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "+") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "-") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "/") ||
        (equation.substring(equation.length - 1) == "×" && buttonText == "=") ||
        (buttonText == "×" && equation == "0") ||
        (buttonText == "%" && equation == "0") ||
        (buttonText == "/" && equation == "0") ||
        (buttonText == "*" && equation == "0") ||
        (buttonText == "+" && equation == "0") ||
        (buttonText == "-" && equation == "0")) {
    } else {
      setState(() {
        if (buttonText == "c") {
          isbool = true;
          expression = "";
          equation = "0";
          widget.txtController.text = "0";
          widget.txtController.selection = TextSelection.fromPosition(TextPosition(offset: widget.txtController.text.length + 1));
          widget.onChange(widget.txtController.text);
          isbool = false;
          equationFontSize = 38.0;
          resultFontSize = 48.0;
        } else if (buttonText == "⌫") {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = equation.substring(0, equation.length - 1);
          if (equation == "") {
            equation = "0";
          }
        } else if (buttonText == "=") {
          equationFontSize = 38.0;
          resultFontSize = 48.0;

          isbool = false;

          expression = equation;
          String str1 = expression;
          List<String> charList = [];
          String ma = "";
          for (int i = 0; i < str1.length; i++) {
            if (str1[i] == "+" ||
                str1[i] == "-" ||
                str1[i] == "×" ||
                str1[i] == "÷" ||
                str1[i] == "/" ||
                str1[i] == "*" ||
                str1[i] == "%") {
              if (ma.isNotEmpty) {
                charList.add(ma);
              }
              charList.add(str1[i]);
              ma = "";
            } else {
              ma = ma + str1[i];
              if (i == str1.length - 1) {
                if (ma.isNotEmpty) {
                  charList.add(ma);
                }
              }
            }
          }

          int l = charList.where((element) => element == "%").toList().length;

          for (int i = 0; i < l; i++) {
            print("charList-->$charList");
            int i = charList.indexWhere((element) => element == "%");
            int a = i - 1;
            int b = i + 1;
            double aa = double.parse(charList[a]);
            double bb = double.parse(charList[b]);
            double cc = (aa * bb) / 100;
            print("cc-->$cc");
            charList[a] = cc.toString();
            print("charList1-->$charList");
            charList.removeAt(b);
            print("charList1-->$charList");
            charList.removeAt(i);
            print("charList1-->$charList");
          }

          String exp = "";
          charList.forEach((element) {
            exp += element;
          });

          print("exp-->$exp");
          expression = exp;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
            result = Utility.getFormatText(double.parse(result).toStringAsFixed(MyColors.decimalFormat));
            expression = "$result";
            equation = "$result";
          } catch (e) {
            result = "";
          }
        } else {
          debugPrint("isbool-->$isbool");
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          if (equation == "0") {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
        }
        isbool ? widget.txtController.text = equation : widget.txtController.text = result;
        widget.txtController.selection = TextSelection.fromPosition(TextPosition(offset: widget.txtController.text.length + 1));

        // getConverterAPI(currencyCodeFrom, currencyCodeTo, isbool ? equation : result);

        isbool = true;
      });
    }
  }
}
