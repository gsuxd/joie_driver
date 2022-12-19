import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.icon,
      this.value,
      this.keyboardType,
      this.controller,
      this.focusNode,
      this.onSubmitted,
      this.onTap,
      required this.validator,
      required this.hintText,
      this.onSaved})
      : super(key: key);

  final String icon;
  final dynamic onSubmitted;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? value;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final String hintText;
  final void Function(String?)? onSaved;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // ignore: prefer_final_fields
  Color _color = Colors.grey;

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: _color, width: 2),
      )),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: _color, width: 2),
            ),
            child: Image.asset(
              widget.icon,
              width: 30,
              color: _color,
            ),
          ),
          Expanded(
            child: TextFormField(
              validator: widget.validator,
              onSaved: widget.onSaved,
              onFieldSubmitted: widget.onSubmitted,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              focusNode: widget.focusNode ?? _focusNode,
              controller: widget.controller,
              onTap: widget.onTap,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: widget.value ?? widget.hintText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
