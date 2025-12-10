import 'package:app_economize_mais/models/product_model.dart';
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
  final ProductModel product;
  final String categoryId;

  const ProductItemDetailsWidget({
    super.key,
    required this.product,
    required this.categoryId,
  });

  @override
  State<ProductItemDetailsWidget> createState() =>
      _ProductItemDetailsWidgetState();
}

class _ProductItemDetailsWidgetState extends State<ProductItemDetailsWidget> {
  late UsuarioProvider usuarioProvider;
  late ProductsEstablishmentProvider productsEstablishmentProvider;
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
      body: Padding(
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
                    image: NetworkImage(widget.product.imageUrl ?? ''),
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
                          '${widget.product.discountPercent}% de desconto',
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
              widget.product.name,
              style: TextStyle(
                color: AppScheme.gray[4],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              widget.product.offerExpiration != null
                  ? 'Vencimento: ${formatStringDate(widget.product.offerExpiration!)}'
                  : 'Sem data de vencimento',
              style: const TextStyle(
                color: AppScheme.red,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'De: R\$${formatDecimalNumber(widget.product.priceOriginal)}',
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
                    'Por R\$ ${formatDecimalNumber(widget.product.priceOffer)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            _productActionButtons(usuarioProvider.userModel!.type),
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
      ),
    );
  }

  void _initialize() {
    usuarioProvider = Provider.of(context, listen: false);
    productsEstablishmentProvider = Provider.of(context, listen: false);
  }

  Widget _productActionButtons(String type) {
    if (type == 'USER') {
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
              onPressed: _editProduct,
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
              onPressed: _deleteProduct,
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

  Future _editProduct() async {}

  Future _deleteProduct() async {
    try {
      setState(() => loading = true);

      await productsEstablishmentProvider.deleteProduct(
          widget.product.id, widget.categoryId);

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
