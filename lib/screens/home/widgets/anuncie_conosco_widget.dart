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
        height: 105,
        child: Card(
          margin: const EdgeInsets.only(left: 10, top: 2, bottom: 9),
          elevation: 2,
          color: AppScheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: AppScheme.gray[4]!),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset('assets/icons/logo-verde.png'),
                ),
                Text(
                  "ANUNCIE COM A GENTE!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppScheme.gray[4],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
