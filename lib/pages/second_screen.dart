import 'package:currency_converter/Themes/colors.dart';
import 'package:flutter/material.dart';

import 'add_currency_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: appheight,
        width: appwidth,

        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
          child: Column(
            children: [
              Container(
                // color: Colors.red,
                width: appwidth - 20,

                child: Row(
                  children: const <Widget>[
                    SizedBox(
                      width: 110,
                    ),
                    Text("Updated:"),
                    SizedBox(
                      width: 5,
                    ),
                    Text("09/23/2021"),
                    SizedBox(
                      width: 50.0,
                    ),
                    Icon(
                      Icons.share,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCurrency()));
        },
        child: const Icon(
          Icons.add,
          size: 40,
          color: Color(0xFF6A78CA),
        ),
      ),
    );
  }
}
