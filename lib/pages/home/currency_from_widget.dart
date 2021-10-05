import 'dart:async';

import 'package:currency_converter/API/apis.dart';

import 'package:currency_converter/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class CurrencyFromWidget extends StatefulWidget {
  final Function(String currencyCode) onSelect;
  const CurrencyFromWidget(
      {required this.isContainerVisible, required this.onSelect, Key? key})
      : super(key: key);
  final bool isContainerVisible;

  @override
  State<CurrencyFromWidget> createState() => _CurrencyFromWidgetState();
}

class _CurrencyFromWidgetState extends State<CurrencyFromWidget> {
  final StreamController<List<CurrencyData>> streamController =
      StreamController();
  TextEditingController edtCurrencyCode = TextEditingController();
  bool starIndex = false;
  bool _isDisposed = false;
  bool _isExpanded = false;
  Map<String, double> currencyMap = {};
  List<CurrencyData> currencyList = [];

  @override
  void initState() {
    if (edtCurrencyCode.text.isEmpty) {
      edtCurrencyCode.text = "";
    }
    super.initState();
    getData();
  }

  Future getData() async {
    currencyMap = await Apiclass.getUser();

    currencyMap.forEach((key, value) {
      currencyList.add(CurrencyData(key: key.toString(), value: value));
    });

    streamController.add(currencyList);
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    starIndex = true;

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // log("===>${widget._isContainerVisible}");
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: AnimatedContainer(
          curve: _isExpanded ? Curves.elasticOut : Curves.easeInSine,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13.0),
          ),
          duration: const Duration(seconds: 0),
          height: widget.isContainerVisible
              ? MediaQuery.of(context).size.height * 0.57
              : 0.0,
          width: widget.isContainerVisible
              ? MediaQuery.of(context).size.width
              : 0.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: TextField(
                  onChanged: (String text) {
                    List<CurrencyData> searchList = [];

                    for (var element in currencyList) {
                      if (element.key
                          .toString()
                          .toLowerCase()
                          .contains(text.trim().toLowerCase())) {
                        searchList.add(element);
                      }
                    }
                    streamController.sink.add(searchList);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 22,
                      color: Colors.black,
                    ),
                    hintText: "Search",
                    hintStyle:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.48,
                child: StreamBuilder<List<CurrencyData>>(
                    stream: streamController.stream,
                    initialData: currencyList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  debugPrint(
                                      "on tap -> ${snapshot.data![index].key}");
                                  widget.onSelect(snapshot.data![index].key);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 2, 10, 0),
                                  decoration: BoxDecoration(
                                    // color: MyColors.textColor,
                                    color: Colors.black45,

                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: ListTile(
                                    leading: const Icon(Icons.image),
                                    title: Row(
                                      children: [
                                        Text(
                                          snapshot.data![index].key,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          snapshot.data![index].value
                                              .toStringAsFixed(3),
                                        ),
                                      ],
                                    ),
                                    trailing: starIndex
                                        ? const Icon(
                                            Icons.star_sharp,
                                            size: 30.0,
                                          )
                                        : const Icon(
                                            Icons.star,
                                            size: 30.0,
                                          ),
                                  ),
                                ),
                              );
                            });
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      }

                      return const Center(
                        child: Text("no data"),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
