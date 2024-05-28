import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final int? maxlength;
  final void Function()? editingComplete;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? suffixIcon;
  final void Function()? onTap;
  final bool? obscureText;
  final FocusNode? focusNode;

  const Input({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.maxlength,
    this.editingComplete,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
    this.obscureText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        validator: validator,
        onEditingComplete: editingComplete,
        style: Theme.of(context).textTheme.bodyLarge,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(onTap: onTap, child: Icon(suffixIcon)),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(55)),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2)),
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          labelText: label,
          // labelStyle: (widget.focusNode ?? focusNode).hasFocus
          //     ? const TextStyle(color: Colors.purple)
          //     : null,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(55))),
        ),
        maxLines: 1,
        maxLength: maxlength,
      ),
    );
  }
}
