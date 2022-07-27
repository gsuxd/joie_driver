import 'package:flutter/material.dart';
import 'package:joiedriver/choose/components/body.dart';

class ChooseScreen extends StatefulWidget {
  static String routeName = '/choose';

  const ChooseScreen({Key? key}) : super(key: key);

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}
