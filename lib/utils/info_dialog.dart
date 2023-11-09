import 'package:flutter/material.dart';

class InforMationDialog extends StatelessWidget {
  const InforMationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: AlertDialog(
        icon: Icon(Icons.gamepad),
      ),
    );
  }
}
