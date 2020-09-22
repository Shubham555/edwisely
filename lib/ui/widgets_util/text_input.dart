import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType inputType;
  final bool obscureText;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final String initialValue;
  final int maxLines;
  final Function onSaved;
  final Function onChanged;
  final Function validator;
  final TextEditingController controller;
  final bool enabled;
  final Widget suffix;


  TextInput({
    @required this.label,
    @required this.hint,
    @required this.inputType,
    this.obscureText = false,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.words,
    this.initialValue,
    this.maxLines = 1,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.controller,
    this.enabled = true,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //heading text
        if (label != null)
          Text(
            label,
            style: textTheme.headline6.copyWith(
              color: Colors.black,
            ),
          ),
        //spacing
        SizedBox(height: 4.0),
        //textfield
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Color(0xFFF2F5FA),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: controller,
                  style: textTheme.headline5,
                  autofocus: autofocus,
                  keyboardType: inputType,
                  textCapitalization: textCapitalization,
                  obscureText: obscureText,
                  initialValue: initialValue,
                  maxLines: maxLines,
                  onSaved: onSaved,
                  onChanged: onChanged,
                  validator: validator,
                  enabled: enabled,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: textTheme.headline6.copyWith(color: Color(0xFF1d1d1d)),
                    errorStyle: TextStyle(
                      color: Color(0xFFFF3F34),
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              suffix != null ? suffix : SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
