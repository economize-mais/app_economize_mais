import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class AnuncieConoscoWidget extends StatelessWidget {
  const AnuncieConoscoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/anuncie-conosco'),
      child: SizedBox(
        width: 124,
        height: 105,
        child: Card(
          margin: const EdgeInsets.only(left: 10, top: 2, bottom: 9),
          elevation: 2,
          color: AppScheme.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DottedBorder(
              color: AppScheme.gray[4]!,
              child: Center(
                child: Text(
                  "Anuncie Conosco",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppScheme.gray[4],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
