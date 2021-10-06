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
                  children: <Widget>[
                    SizedBox(
                      width: appwidth * 0.255,
                    ),
                    const Center(
                      child: Text(
                        "Updated:",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Center(
                      child: Text(
                        "09/23/2021",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: appwidth * 0.15,
                    ),
                    const Icon(
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
