import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String keyFormData;
  final Map<String, Object> formData;
  final String labelText;
  final Function validator;
  final bool autofocus;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Function onFieldSubmitted;
  final Function onChanged;

  const CustomTextFormField(
      {@required this.keyFormData,
      @required this.formData,
      @required this.labelText,
      this.validator,
      this.autofocus = false,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.keyboardType,
      this.onFieldSubmitted,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        key: ValueKey(keyFormData),
        obscureText: obscureText,
        initialValue: formData[keyFormData],
        autofocus: autofocus,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide.none)),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: (value) {
          formData[keyFormData] = value;
          //print(formData[keyFormData]);
          //onChanged(value);
        },
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
      ),
    );
  }
}
