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
  final int maxLength;
  final Function onSaved;
  final Function onChanged;
  final Function validator;
  final TextEditingController controller;
  final bool enabled;
  final Widget suffix;
  final bool isWhite;

  TextInput({
    @required this.label,
    @required this.hint,
    @required this.inputType,
    this.obscureText = false,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.words,
    this.initialValue,
    this.maxLines = 1,
    this.maxLength,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.controller,
    this.enabled = true,
    this.suffix,
    this.isWhite = false,
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
              color: isWhite ? Colors.white : Colors.black,
            ),
          ),
        //spacing
        SizedBox(height: 4.0),
        //textfield
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 0.5,
            ),
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
                  maxLength: maxLength,
                  onSaved: onSaved,
                  onChanged: onChanged,
                  validator: validator,
                  enabled: enabled,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle:
                        textTheme.headline6.copyWith(color: Colors.grey[400]),
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
