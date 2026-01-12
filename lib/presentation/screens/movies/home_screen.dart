import 'package:flutter/material.dart';
import 'package:pelis_info/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final Widget childView;
  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: CustomBottonNavigationbar(),
    );
  }
}