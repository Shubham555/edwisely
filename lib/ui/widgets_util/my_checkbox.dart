import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final bool value;
  final Function onChanged;

  MyCheckbox({
    @required this.value,
    @required this.onChanged,
  });

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.0,
      width: 35.0,
      child: InkWell(
        onTap: widget.onChanged,
        child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(4.0),
          //   border: Border.all(
          //     color: Colors.white,
          //     width: 2.0,
          //   ),
          // ),
          child: widget.value
              ? Icon(
                  Icons.done,
                  color: Colors.white,
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
