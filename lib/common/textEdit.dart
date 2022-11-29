import 'package:flutter/material.dart';

class EditTextWidget extends StatefulWidget {
  const EditTextWidget(
      {Key? key, required this.globalFormKey, required this.textController})
      : super(key: key);
  final GlobalKey<FormState> globalFormKey;
  final TextEditingController textController;
  @override
  State<EditTextWidget> createState() => _EditTextWidgetState();
}

class _EditTextWidgetState extends State<EditTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.globalFormKey,
      child: TextFormField(
        controller: widget.textController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Colors.greenAccent,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
        ),
      ),
    );
  }
}
