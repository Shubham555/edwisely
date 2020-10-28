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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 34.0),
      child: SizedBox(
        height: 35.0,
        width: 35.0,
        child: InkWell(
          onTap: widget.onChanged,
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: widget.value
                ? Transform.translate(
                    offset: Offset(0, -5),
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
