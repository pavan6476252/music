
import 'package:flutter/material.dart';


class Responsive extends StatelessWidget {
  const Responsive({required this.mobileResponsive,super.key});
 final Widget mobileResponsive;

  @override
  Widget build(BuildContext context) {
    return mobileResponsive;
  }
}