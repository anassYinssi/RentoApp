import 'package:rento/shared/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final Icon prefixIcon;
  final Icon ?sufixIcon;
  final String label ;
  final bool isPassword ;
  final TextInputType? keboardType;
  final FormFieldValidator<String>? validator;

   const CustomTextField({Key?key,
    required this.controller,
    required this.label,
    required this.isPassword,
    this.keboardType, 
    this.hint, 
    this.validator,
    this.sufixIcon,
    required this.prefixIcon

  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        
        controller: controller,
        keyboardType: keboardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          hintText: hint,
          fillColor: superClear,
          label: Text(label,style: TextStyle(color: clear),),
          focusedBorder: 
          OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:  BorderSide(color:clear),),
          enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:clear) 
          )
        ),
        validator: validator,
        obscureText: isPassword,
        

      ),
    );
    
  }
}