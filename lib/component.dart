import 'package:flutter/material.dart';
import 'list.dart';

class CustomSizedTextform extends StatelessWidget {
  final double height;
  final String text;
  final String hinttext;
  final TextEditingController controllerr;
  final TextInputType keyboardtype;
  final int? maxlenght;
  final FormFieldValidator<String>? validate;
  const CustomSizedTextform(
      {super.key,
      required this.height,
      required this.text,
      required this.hinttext,
      required this.keyboardtype,
      required this.maxlenght,
      required this.validate,
      required this.controllerr});

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controllerr,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(text),
            hintText: hinttext),
        keyboardType: keyboardtype,
        maxLength: maxlenght,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validate,
      ),
    );
  }
}

List<Profiles> favprofile = List.empty(growable: true);
List<Profiles> searchProfile = List.empty(growable: true);
