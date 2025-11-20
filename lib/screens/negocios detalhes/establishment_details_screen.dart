import 'package:app_economize_mais/models/establishment_model.dart';
import 'package:app_economize_mais/providers/products_establishment_provider.dart';
import 'package:app_economize_mais/screens/negocios%20detalhes/widget/products_establishment_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/custom_fade_in_image_widget.dart';
import 'package:app_economize_mais/utils/widgets/filter_search_text_field_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/tentar_novamente_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer, Provider;

class EstablishmentDetailsScreen extends StatefulWidget {
  final String type;
  final EstablishmentModel establishment;

  const EstablishmentDetailsScreen({
    super.key,
    required this.type,
    required this.establishment,
  });

  @override
  State<EstablishmentDetailsScreen> createState() =>
      _EstablishmentDetailsScreenState();
}

class _EstablishmentDetailsScreenState
    extends State<EstablishmentDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: ''),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FilterSearchTextFieldWidget(),
            const SizedBox(height: 15),
            Text(
              widget.type,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            CustomFadeInImageWidget(
                width: 163,
                height: 79,
                image: NetworkImage(widget.establishment.logoUrl ?? '')),
            const SizedBox(height: 2),
            Visibility(
              visible: widget.establishment.street?.isNotEmpty ?? false,
              child: Text(
                widget.establishment.street ?? '',
                style: TextStyle(
                  color: AppScheme.gray[4],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(
              height: 4,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Consumer<ProductsEstablishmentProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return CustomCircularProgressIndicator(
                    text: 'Carregando produtos...',
                  );
                }

                if (provider.hasError) {
                  return TentarNovamenteWidget(
                      title:
                          'Não foi possível buscar os produtos. Por favor, tente novamente.'
                          '\nErro: ${provider.errorMessage}',
                      onPressed: _initialize);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: provider.productsEstablishment.length,
                  itemBuilder: (context, i) => ProductsEstablishmentWidget(
                      type: provider.productsEstablishment[i].categoryName,
                      productsEstablishment: provider.productsEstablishment[i]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _initialize() {
    final ProductsEstablishmentProvider productsEstablishmentProvider =
        Provider.of(context, listen: false);

    productsEstablishmentProvider
        .getProductsEstablishment(widget.establishment.id);
  }
}
