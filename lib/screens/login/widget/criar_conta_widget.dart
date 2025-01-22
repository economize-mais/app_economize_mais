import 'package:flutter/material.dart';

class CriarContaWidget extends StatelessWidget {
  const CriarContaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Não possui uma conta?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
        OutlinedButton(
          onPressed: () => Navigator.pushNamed(context, '/cadastro'),
          child: const Text('Criar nova conta'),
        ),
      ],
    );
  }
}
