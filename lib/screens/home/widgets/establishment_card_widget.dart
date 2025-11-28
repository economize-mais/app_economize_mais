import 'package:app_economize_mais/models/establishment_model.dart';
import 'package:app_economize_mais/utils/widgets/custom_fade_in_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:go_router/go_router.dart';

class EstablishmentCardWidget extends StatelessWidget {
  final String type;
  final EstablishmentModel establishment;
  final double width;
  final double height;

  const EstablishmentCardWidget({
    super.key,
    required this.type,
    required this.establishment,
    this.width = 124,
    this.height = 105,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/establishment-details', extra: {
        "type": type,
        "establishment": establishment,
      }),
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          margin: const EdgeInsets.only(top: 2, bottom: 9),
          color: AppScheme.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: CustomFadeInImageWidget(
                      image: NetworkImage(establishment.logoUrl ?? ''),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  establishment.name,
                  style: TextStyle(
                    color: AppScheme.gray[4],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  establishment.street ?? '',
                  style: TextStyle(
                    color: AppScheme.gray[4],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
