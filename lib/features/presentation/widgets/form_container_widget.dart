import "package:flutter/material.dart";
import "package:insta_clone/utils/colors.dart";

class FormConatinerField extends StatefulWidget {
  const FormConatinerField(
      {super.key,
      this.formController,
      this.fieldKey,
      this.isPasswordField,
      this.helperText,
      this.hintText,
      this.labeltext,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputType});
  final TextEditingController? formController;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? helperText;
  final String? hintText;
  final String? labeltext;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  @override
  State<FormConatinerField> createState() => _FormConatinerFieldState();
}

class _FormConatinerFieldState extends State<FormConatinerField> {
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: const TextStyle(color: primaryColor),
        controller: widget.formController,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _isObscureText : false,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        keyboardType: widget.inputType,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          fillColor: secondaryColor.withOpacity(0.1),
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          focusColor: primaryColor,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: secondaryColor),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _isObscureText = !_isObscureText;
              });
            },
            child: widget.isPasswordField == true
                ? Icon(
                    _isObscureText ? Icons.visibility_off : Icons.visibility,
                    color: _isObscureText ? secondaryColor : blueColor,
                  )
                : const Text(""),
          ),
        ),
      ),
    );
  }
}
