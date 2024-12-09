import 'package:flutter/material.dart';

class SubModulPage extends StatefulWidget {
  const SubModulPage({super.key});

  @override
  State<SubModulPage> createState() => _SubModulPageState();
}

class _SubModulPageState extends State<SubModulPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Halaman SubModul"),
      ),
    );
  }
}