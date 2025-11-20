import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double? size;
  final String? text;

  const CustomCircularProgressIndicator({
    super.key,
    this.size,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: size,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppScheme.brightGreen,
              ),
            ),
          ),
          if (text != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                text!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
