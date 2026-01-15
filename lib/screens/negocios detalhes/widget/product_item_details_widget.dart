import 'package:app_economize_mais/models/product_model.dart';
import 'package:app_economize_mais/providers/categories_provider.dart';
import 'package:app_economize_mais/providers/products_establishment_provider.dart';
import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/utils/functions/format_types.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/custom_fade_in_image_widget.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductItemDetailsWidget extends StatefulWidget {
  final String productId;
  final String categoryId;
  final String establishmentId;

  const ProductItemDetailsWidget({
    super.key,
    required this.productId,
    required this.categoryId,
    required this.establishmentId,
  });

  @override
  State<ProductItemDetailsWidget> createState() =>
      _ProductItemDetailsWidgetState();
}

class _ProductItemDetailsWidgetState extends State<ProductItemDetailsWidget> {
  late ProductsEstablishmentProvider productsEstablishmentProvider;
  late bool alcoholicBeverage;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        title: 'Produto',
        hideActions: true,
      ),
      body: Consumer<ProductsEstablishmentProvider>(
          builder: (context, provider, child) {
        final product =
            provider.findProductById(widget.productId, widget.categoryId);

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomFadeInImageWidget(
                      height: 230,
                      width: 268,
                      fit: BoxFit.contain,
                      image: NetworkImage(product.imageUrl ?? ''),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: AppScheme.brightGreen,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            '${formatDecimalNumber(product.discountPercent)}% de desconto',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppScheme.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                product.name,
                style: TextStyle(
                  color: AppScheme.gray[4],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              if (product.weight != null && product.weight != '0')
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Peso: ${product.weight} ${product.unitOfMeasure}',
                    style: TextStyle(
                      color: AppScheme.gray[4],
                      fontSize: 14,
                    ),
                  ),
                ),
              if (product.productExpirationDate != null &&
                  product.productExpirationDate!.trim() != '')
                Text(
                  'Vencimento: ${formatStringDate(product.productExpirationDate!)}',
                  style: const TextStyle(
                    color: AppScheme.red,
                    fontSize: 12,
                  ),
                ),
              const SizedBox(height: 25),
              Text(
                'De: R\$${formatDecimalNumber(product.priceOriginal)}',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppScheme.red,
                  color: AppScheme.red,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                constraints: BoxConstraints(
                  minWidth: 150,
                  minHeight: 50,
                ),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppScheme.brightGreen,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Por R\$ ${formatDecimalNumber(product.priceOffer)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Visibility(
                visible: alcoholicBeverage,
                child: Text('Venda proibida para menores de 18 anos'),
              ),
              const Spacer(),
              _productActionButtons(product),
              const Spacer(),
              Text(
                'Vendas somente na loja',
                style: TextStyle(
                  color: AppScheme.gray[4],
                  fontSize: 16,
                ),
              ),
              Text(
                'Promoção válida enquanto durarem os estoques',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppScheme.gray[4],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _initialize() {
    productsEstablishmentProvider = Provider.of(context, listen: false);

    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    alcoholicBeverage =
        categoriesProvider.isAlcoholicBeverage(widget.categoryId);
  }

  Widget _productActionButtons(ProductModel product) {
    final userModel =
        Provider.of<UsuarioProvider>(context, listen: false).userModel!;
    bool isSameEstablishment = userModel.id == widget.establishmentId;

    if (userModel.type == 'USER' || !isSameEstablishment) {
      return const SizedBox.shrink();
    }

    return Visibility(
      visible: !loading,
      replacement: CustomCircularProgressIndicator(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () => _editProduct(product),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Editar'),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: FilledButton(
              onPressed: () => _deleteProduct(product),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Excluir'),
            ),
          ),
        ],
      ),
    );
  }

  void _editProduct(ProductModel product) {
    context.go('/announcements/edit-product-item',
        extra: {"product": product, "categoryId": widget.categoryId});
  }

  Future _deleteProduct(ProductModel product) async {
    try {
      setState(() => loading = true);

      await productsEstablishmentProvider.deleteProduct(
          product.id, widget.categoryId);

      if (!mounted) return;

      if (productsEstablishmentProvider.hasError) {
        return showDialog(
          context: context,
          builder: (context) => PopupErrorWidget(
              content: productsEstablishmentProvider.errorMessage),
        );
      }

      await showDialog(
        context: context,
        builder: (context) => const PopupErrorWidget(
          title: 'Sucesso!',
          content: 'O produto foi excluído.',
        ),
      );
      if (!mounted) return;

      context.pop();
    } catch (e) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(content: e.toString()),
      );
    } finally {
      setState(() => loading = false);
    }
  }
}
