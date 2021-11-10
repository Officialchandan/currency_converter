import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  final TextEditingController txtController;
  final Function(String text) onChange;

  Calculator({required this.txtController, required this.onChange, Key? key})
      : super(key: key);

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

    debugPrint("initialEquation->$equation");
    debugPrint("initialEquation->$expression");
    debugPrint("initialtext->${widget.txtController.text}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              // height: MediaQuery.of(context).size.height * 0.35,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("%", 1, MyColors.calcuColor, 18),
                    buildButton("/", 1, MyColors.calcuColor, 18),
                    buildButton("×", 1, MyColors.calcuColor, 25),
                  ]),
                  TableRow(children: [
                    buildButton("1", 1, MyColors.calcuColor, 18),
                    buildButton("2", 1, MyColors.calcuColor, 18),
                    buildButton("3", 1, MyColors.calcuColor, 18),
                  ]),
                  TableRow(children: [
                    buildButton("4", 1, MyColors.calcuColor, 18),
                    buildButton("5", 1, MyColors.calcuColor, 18),
                    buildButton("6", 1, MyColors.calcuColor, 18),
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, MyColors.calcuColor, 18),
                    buildButton("8", 1, MyColors.calcuColor, 18),
                    buildButton("9", 1, MyColors.calcuColor, 18),
                  ]),
                  TableRow(children: [
                    buildButton(".", 1, MyColors.calcuColor, 23),
                    buildButton("0", 1, MyColors.calcuColor, 18),
                    buildButton("c", 1, MyColors.calcuColor, 18),
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
                    Center(child: buildButton("=", 2, MyColors.calcuColor, 40)),
                  ]),
                ]))
          ],
        ),
      ),
    );
  }

  buildButton(String buttonText, double buttonHeight, Color buttonColor,
      double buttonTexth) {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.left,
            ),
            height: MediaQuery.of(context).size.height * 0.057 * buttonHeight,
            color:
                MyColors.lightModeCheck ? Colors.white : MyColors.colorPrimary,
            child: Container(
              //**Alline height */
              //This is grate

              // color: Colors.grey,

              decoration: MyColors.lightModeCheck
                  ? BoxDecoration(
                      border: Border.all(
                          color: MyColors.colorPrimary,
                          width: 0.4,
                          style: BorderStyle.solid),
                      gradient: LinearGradient(
                        colors: [
                          MyColors.colorPrimary.withOpacity(.7),
                          MyColors.colorPrimary.withOpacity(.45),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,

                        //stops: [0.0,0.0]
                      ))
                  : BoxDecoration(
                      border: Border.all(
                          color: MyColors.colorPrimary,
                          width: 0.4,
                          style: BorderStyle.solid),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black54.withOpacity(.30),
                          Colors.black54.withOpacity(.20),
                        ],

                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,

                        //stops: [.7,9.0]
                      )),

              child: MaterialButton(
                  onLongPress: () {
                    if (buttonText == "⌫") {
                      expression = "";
                      // equation = "0";
                      widget.txtController.clear();
                      _insertText("0");
                      // widget.txtController.text = "0";
                      // widget.onChange(widget.txtController.text);
                    }
                    // buttonPressed(buttonText);
                    // equation = "0";
                  },
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(0.0),
                  //     side: BorderSide(color: MyColors.colorPrimary, width: 0.4, style: BorderStyle.solid)
                  // ),
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () => buttonPressed(buttonText),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: buttonText == "⌫"
                          ? Icon(
                              Icons.backspace_sharp,
                              color: MyColors.textColor,
                              size: buttonTexth,
                            )
                          : buttonText == "×"
                              ? Icon(
                                  Icons.clear,
                                  color: MyColors.textColor,
                                  size: buttonTexth,
                                )
                              : Text(
                                  buttonText.toUpperCase(),
                                  textScaleFactor: Constants.textScaleFactor,
                                  style: TextStyle(
                                      fontSize: buttonTexth,
                                      fontWeight: FontWeight.normal,
                                      color: MyColors.textColor),
                                ),
                    ),
                  )),
            )));
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
        (equation.substring(equation.length - 1) == "." && buttonText == ".") ||
        (buttonText == "×" && equation == "0") ||
        (buttonText == "%" && equation == "0") ||
        (buttonText == "/" && equation == "0") ||
        (buttonText == "×" && equation == "0") ||
        (buttonText == "+" && equation == "0") ||
        (buttonText == "-" && equation == "0")) {
      debugPrint("nothing");
    } else {
      setState(() {
        if((!equation.contains("+")&&!equation.contains("-")&&!equation.contains("×")&&!equation.contains("/")&&!equation.contains("%"))&&buttonText=="="){
          return;

        }

        if (buttonText == "c") {
          isbool = true;
          expression = "";
          widget.txtController.clear();
          _insertText("0");
          // equation = "0";
          // widget.txtController.text = "0";
          // widget.onChange(widget.txtController.text);
          isbool = false;
          equationFontSize = 38.0;
          resultFontSize = 48.0;
        } else if (buttonText == "⌫") {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          _backspace();
          setState(() {

          });
          // equation = equation.substring(0, equation.length - 1);
          // if (equation == "") {
          //   equation = "0";
          // }
          // isbool ? widget.txtController.text = equation : widget.txtController.text = result;
          // widget.onChange(widget.txtController.text);

        } else if (buttonText == "=") {
          
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          isbool = true;
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
            int i = charList.indexWhere((element) => element == "%");
            int a = i - 1;
            int b = i + 1;
            double aa = double.parse(charList[a]);
            double bb = double.parse(charList[b]);
            double cc = (aa * bb) / 100;
            charList[a] = cc.toString();
            charList.removeAt(b);
            charList.removeAt(i);
          }

          String exp = "";
          for (var element in charList) {
            exp += element;
          }

          print("exp-->$exp");
          expression = exp;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');

          try {
            Parser p = Parser();
            Expression expn = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${expn.evaluate(EvaluationType.REAL, cm)}';
            result =
                double.parse(result).toStringAsFixed(MyColors.decimalFormat);
            expression = result;
            equation = result;
            widget.txtController.clear();
            _insertText(result);
            // widget.onChange(widget.txtController.text);
          } catch (e) {
            debugPrint("exception-->$e");
            // result = "";
            // expression = result;
            // equation = result;
            // isbool ? widget.txtController.text = equation : widget.txtController.text = result;
            // widget.onChange(widget.txtController.text);
          }
        } else {
          debugPrint("isbool-->$isbool");
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          if (equation == "0") {
            widget.txtController.clear();
            _insertText(buttonText);
          } else {
            _insertText(buttonText);
          }
        }
        // isbool ? widget.txtController.text = equation : widget.txtController.text = result;
        // widget.onChange(widget.txtController.text);
        // isbool = true;
      });
    }
  }

  void _insertText(String myText) {
    final text = widget.txtController.text;
    final textSelection = widget.txtController.selection;

    if (text.isNotEmpty) {
      if (myText == "+" ||
          myText == "-" ||
          myText == "×" ||
          myText == "÷" ||
          myText == "/" ||
          myText == "*" ||
          myText == "%") {
        debugPrint("myText contain operator");
        String previousText = text[textSelection.start - 1];

        if (previousText == "+" ||
            previousText == "-" ||
            previousText == "×" ||
            previousText == "÷" ||
            previousText == "/" ||
            previousText == "*" ||
            previousText == "%") {
          debugPrint("and it previousText is also is a operator");
          return;
        }
      }
    }

    debugPrint("text->$text");
    debugPrint("cursor position->${textSelection.start}");

    // if (text.length > textSelection.start) {
    //   print(text.length >= textSelection.start);
    //   if (myText == "+" || myText == "-" || myText == "×" || myText == "÷" || myText == "/" || myText == "*" || myText == "%") {
    //     debugPrint("myText contain operator");
    //     String previousText = text[textSelection.start];
    //     debugPrint("next text ->$previousText");
    //
    //     if (previousText == "+" ||
    //         previousText == "-" ||
    //         previousText == "×" ||
    //         previousText == "÷" ||
    //         previousText == "/" ||
    //         previousText == "*" ||
    //         previousText == "%") {
    //       debugPrint("and it previousText is also is a operator");
    //       return;
    //     }
    //   }
    // }

    if (myText == ".") {
      String mText = text;
      int pos = textSelection.start;
      List<String> str = mText.split("");
      debugPrint("pos-->$pos");
      debugPrint("str-->$str");
      String temp1 = "";
      String temp = "";
      if (mText.length > pos) {
        for (int i = pos; i <= str.length; i++) {
          if (str[i] == "+" ||
              str[i] == "-" ||
              str[i] == "×" ||
              str[i] == "÷" ||
              str[i] == "/" ||
              str[i] == "*" ||
              str[i] == "%") {
            break;
          } else {
            temp1 += str[i];
          }
        }
      }
      debugPrint("temp1-->$temp1");
      debugPrint("pos-->$pos");
      for (int j = 0; j < pos; j++) {
        if (str[j] == "+" ||
            str[j] == "-" ||
            str[j] == "×" ||
            str[j] == "÷" ||
            str[j] == "/" ||
            str[j] == "*" ||
            str[j] == "%") {
          temp = "";
        } else {
          temp += str[j];
        }
      }

      String temp3 = temp + temp1;

      if (temp3.contains(".")) {
        return;
      }

      debugPrint("temp-->$temp");
    }

    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    debugPrint("newText$newText");
    final myTextLength = myText.length;
    widget.txtController.text = newText;
    equation = widget.txtController.text;
    expression = equation;
    widget.txtController.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
    widget.onChange(widget.txtController.text);
  }

  void _backspace() {
    final text = widget.txtController.text;
    final textSelection = widget.txtController.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      widget.txtController.text = newText;
      widget.txtController.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );

    widget.txtController.text = newText;
    if (widget.txtController.text.isEmpty) {
      widget.txtController.text = "0";
      equation = "0";
      expression = "";
      result = "0";
    }
    widget.txtController.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
    widget.onChange(widget.txtController.text);
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }
}
