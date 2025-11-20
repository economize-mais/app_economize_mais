import 'package:flutter/material.dart';

class TentarNovamenteWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const TentarNovamenteWidget(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
          ),
          OutlinedButton(onPressed: onPressed, child: Text('Tentar novamente')),
        ],
      ),
    );
  }
}
