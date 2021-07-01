import 'package:flutter/material.dart';

class NewTextFormField extends StatelessWidget {
  final String keyFormData;
  final Map<String, Object> formData;
  final String labelText;
  final Function validator;
  final bool autofocus;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Function onFieldSubmitted;
  final Function onChanged;

  const NewTextFormField({
    @required this.keyFormData,
    @required this.formData,
    @required this.labelText,
    this.validator,
    this.autofocus = false,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(keyFormData),
      initialValue: formData[keyFormData],
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 14.0, color: Colors.black54),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        border: const OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: (value) {
        formData[keyFormData] = value;
        if (onChanged != null) onChanged(value);
      },
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}
