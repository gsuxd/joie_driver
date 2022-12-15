import 'package:flutter/material.dart';

/// Custom textField for the methods of payment
/// [placeHolder] is the text that will be shown in the textField
/// [controller] is the controller of the textField
/// [icon] is the icon that will be shown in the left of the textField
class CustomTextField extends StatefulWidget {
  final String placeHolder;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final int maxLength;
  final bool disabled;
  const CustomTextField(
      {Key? key,
      required this.validator,
      required this.disabled,
      required this.icon,
      required this.placeHolder,
      required this.maxLength,
      required this.controller})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // ignore: prefer_final_fields
  Color _color = Colors.grey;
  final FocusNode _focusNode = FocusNode();

  void _focusListener() {
    if (_focusNode.hasFocus) {
      setState(() {
        _color = Colors.blue;
      });
    } else {
      setState(() {
        _color = Colors.grey;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: _color,
          width: 1,
        ),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              focusNode: _focusNode,
              readOnly: widget.disabled,
              validator: widget.validator,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                hintText: widget.placeHolder,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                counterText: "",
              ),
              controller: widget.controller,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(
              widget.icon,
              color: _color,
            ),
          )
        ],
      ),
    );
  }
}
