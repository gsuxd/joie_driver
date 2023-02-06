import 'package:flutter/material.dart';
import '../size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => errorMesage(error: errors[index])),
    );
  }

  Row errorMesage({required String error}) {
    return Row(children: [
      SizedBox(
        width: getPropertieScreenWidth(18),
      ),
      const Icon(Icons.dangerous_outlined, color: Colors.red),
      SizedBox(
        width: getPropertieScreenWidth(1),
      ),
      Text(error),
    ]);
  }
}
