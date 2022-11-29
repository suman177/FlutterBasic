import 'dart:convert';
import 'package:assessment/pages/home/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../common/textEdit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic jsonResult;
  String errorText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Add Total Boxes Controller listener
    _totalBoxesController.addListener(() {
      final int text = int.parse(
          _totalBoxesController.text == "" ? "0" : _totalBoxesController.text);
      if (text > 11) {
        setState(() {
          errorText = jsonResult['errorMessage7'];
        });
      } else {
        errorText = "";
        context.read<SelectionProvider>().totalBoxes = text;
      }
    });
    _maxSelectionController.addListener(() {
      final int text = int.parse(_maxSelectionController.text == ""
          ? "0"
          : _maxSelectionController.text);
      int totalBox = (context.read<SelectionProvider>().totalBoxes * 2);

      if (text > totalBox) {
        setState(() {
          errorText = jsonResult['errorMessage4S1'] +
              totalBox.toString() +
              jsonResult['errorMessage4S2'];
        });
      } else {
        errorText = "";
        context.read<SelectionProvider>().maxAllowedSelection = text;
      }
    });
    _maxAlphaController.addListener(() {
      final int text = int.parse(
          _maxAlphaController.text == "" ? "0" : _maxAlphaController.text);
      int totalBoxes = context.read<SelectionProvider>().totalBoxes;
      if (text > totalBoxes) {
        setState(() {
          errorText = jsonResult['errorMessage5S1'] +
              totalBoxes.toString() +
              jsonResult["errorMessage5S2"];
        });
      } else {
        errorText = "";
        context.read<SelectionProvider>().maxAlphaAllowed = text;
      }
    });
    _maxNumberController.addListener(() {
      final int text = int.parse(
          _maxNumberController.text == "" ? "0" : _maxNumberController.text);
      int totalBoxes = context.read<SelectionProvider>().totalBoxes;

      if (text > context.read<SelectionProvider>().totalBoxes) {
        setState(() {
          errorText = jsonResult['errorMessage6S1'] +
              totalBoxes.toString() +
              jsonResult["errorMessage6S2"];
        });
      } else {
        errorText = "";
        context.read<SelectionProvider>().maxNumberAllowed = text;
      }
    });

    loadJson();
  }

  @override
  void dispose() {
    _totalBoxesController.dispose();
    super.dispose();
  }

  loadJson() async {
    var jsonText = await rootBundle.loadString('assets/message.json');
    setState(() {
      jsonResult = jsonDecode(jsonText); //latest Dart
    });
  }

  int char = 65;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (jsonResult == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
        appBar: _appBar(), body: _body(), bottomSheet: _buttomSheet());
  }

  final GlobalKey<FormState> _totalBoxesKey = GlobalKey<FormState>();
  final TextEditingController _totalBoxesController = TextEditingController();
  final GlobalKey<FormState> _maxSelectionKey = GlobalKey<FormState>();
  final TextEditingController _maxSelectionController = TextEditingController();
  final GlobalKey<FormState> _maxAlphaKey = GlobalKey<FormState>();
  final TextEditingController _maxAlphaController = TextEditingController();
  final GlobalKey<FormState> _maxNumberKey = GlobalKey<FormState>();
  final TextEditingController _maxNumberController = TextEditingController();

  final double _appBarHeight = 220;
  final double _bottomSheetHeight = 50;

  AppBar _appBar() {
    return AppBar(
      toolbarHeight: _appBarHeight,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        jsonResult['totalBoxesMessage'],
                        textAlign: TextAlign.right,
                      ),
                    )),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0),
                    child: EditTextWidget(
                      globalFormKey: _totalBoxesKey,
                      textController: _totalBoxesController,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        jsonResult['maxSelection'],
                        textAlign: TextAlign.right,
                      ),
                    )),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0),
                    child: EditTextWidget(
                      globalFormKey: _maxSelectionKey,
                      textController: _maxSelectionController,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        jsonResult['maxAlpha'],
                        textAlign: TextAlign.right,
                      ),
                    )),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0),
                    child: EditTextWidget(
                      globalFormKey: _maxAlphaKey,
                      textController: _maxAlphaController,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        jsonResult['maxNumber'],
                      ),
                    )),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0),
                    child: EditTextWidget(
                      globalFormKey: _maxNumberKey,
                      textController: _maxNumberController,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    final provider = Provider.of<SelectionProvider>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: _bottomSheetHeight + 3, top: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              width: width / 2,
              child: ListView.builder(
                primary: true,
                itemCount: provider.totalBoxes,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 20,
                        width: width,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Checkbox(
                                checkColor: Colors.red,
                                activeColor: Colors.amberAccent,
                                value: provider.isSelectedAlpha(index),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                onChanged: (bool? value) {
                                  // print(provider.isValidMaxAllowedSelection());
                                  if (value ?? false) {
                                    if (provider.isValidMaxAllowedSelection()) {
                                      if (provider.isMaxAlphaValid()) {
                                        setState(() {
                                          errorText = "";
                                          provider.selectAlpha(
                                              index, value ?? false);
                                        });
                                      } else {
                                        setState(() {
                                          errorText =
                                              jsonResult["errorMessage1"];
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        errorText = jsonResult["errorMessage3"];
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      errorText = "";
                                      provider.selectAlpha(
                                          index, value ?? false);
                                    });
                                  }
                                },
                              ),
                            ),
                            Expanded(
                                child: Text(String.fromCharCode(char + index)
                                    .toString())),
                          ],
                        ))),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: width / 2,
              child: ListView.builder(
                primary: true,
                itemCount: provider.totalBoxes,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 20,
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Checkbox(
                                checkColor: Colors.red,
                                activeColor: Colors.amberAccent,
                                value: provider.isSelectedNumber(index),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                onChanged: (bool? value) {
                                  if (value ?? false) {
                                    if (provider.isValidMaxAllowedSelection()) {
                                      if (provider.isMaxNumberValid()) {
                                        setState(() {
                                          errorText = "";
                                          provider.selectedNumber(
                                              index, value ?? false);
                                        });
                                      } else {
                                        setState(() {
                                          errorText =
                                              jsonResult["errorMessage2"];
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        errorText = jsonResult["errorMessage3"];
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      errorText = "";
                                      provider.selectedNumber(
                                          index, value ?? false);
                                    });
                                  }
                                },
                              ),
                            ),
                            Expanded(child: Text((index + 1).toString())),
                          ],
                        )),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttomSheet() {
    return SizedBox(
      height: 50,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _totalBoxesController.text = "";
                    _maxSelectionController.text = "";
                    _maxNumberController.text = "";
                    _maxAlphaController.text = "";
                  },
                  child: Container(
                    color: Colors.purple,
                    child: Center(
                      child: Text(
                        jsonResult["resetMessage"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )),
            Flexible(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: errorText.isEmpty ? Colors.green : Colors.red),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        errorText.isEmpty ? "success" : errorText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )),
          ]),
    );
  }
}
