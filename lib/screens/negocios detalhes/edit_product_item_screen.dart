import 'dart:io';

import 'package:app_economize_mais/models/category_model.dart';
import 'package:app_economize_mais/models/product_model.dart';
import 'package:app_economize_mais/providers/categories_provider.dart';
import 'package:app_economize_mais/providers/product_provider.dart';
import 'package:app_economize_mais/providers/products_establishment_provider.dart';
import 'package:app_economize_mais/screens/announcement/widgets/product_container_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/functions/choose_gallery_camera_dialog.dart';
import 'package:app_economize_mais/utils/functions/format_types.dart';
import 'package:app_economize_mais/utils/functions/product/send_product_image.dart';
import 'package:app_economize_mais/utils/functions/validate_category_controller.dart';
// import 'package:app_economize_mais/utils/widgets/checkbox_list_tile_item_widget.dart';
import 'package:app_economize_mais/utils/widgets/custom_autocomplete_widget.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
// import 'package:app_economize_mais/utils/widgets/labeled_outline_date_picker_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:app_economize_mais/utils/widgets/tentar_novamente_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProductItemScreen extends StatefulWidget {
  final ProductModel product;
  final String categoryId;

  const EditProductItemScreen(
      {super.key, required this.product, required this.categoryId});

  @override
  State<EditProductItemScreen> createState() => _EditProductItemScreenState();
}

class _EditProductItemScreenState extends State<EditProductItemScreen> {
  late CategoriesProvider _categoriesProvider;

  late TextEditingController categoriaController;
  late TextEditingController descricaoController;
  // late TextEditingController pesoLiquidoController;
  // late TextEditingController dataValidadeController;
  late TextEditingController valorDeController;
  late TextEditingController valorParaController;
  // late TextEditingController validadeOfertaInicioController;
  late TextEditingController validadeOfertaFimController;
  late GlobalKey<FormState> _formKey;
  File? image;
  bool naoTemValidade = false;

  bool isLoading = true;
  bool sendingRequest = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initialize());
  }

  @override
  void dispose() {
    disposeTextControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        title: 'Editar Anúncio',
        hideActions: true,
      ),
      body: Consumer<CategoriesProvider>(
        builder: (context, provider, child) {
          if (isLoading) {
            return CustomCircularProgressIndicator(
              text: 'Carregando informações...',
            );
          }

          if (provider.hasError) {
            return TentarNovamenteWidget(
                title:
                    'Não foi possível buscar as informações. Por favor, tente novamente.',
                onPressed: () => initialize(tryAgain: true));
          }

          return _buildContent(provider.categoriesList);
        },
      ),
    );
  }

  void setTextControllers() {
    _formKey = GlobalKey<FormState>();

    final String textCategoria = _categoriesProvider.categoriesList
        .firstWhere((item) => item.id == widget.categoryId)
        .name;
    categoriaController = TextEditingController(text: textCategoria);
    descricaoController = TextEditingController(text: widget.product.name);
    // pesoLiquidoController = TextEditingController();
    // dataValidadeController = TextEditingController();
    valorDeController = TextEditingController(
        text: formatDecimalNumber(widget.product.priceOriginal));
    valorParaController = TextEditingController(
        text: formatDecimalNumber(widget.product.priceOffer));

    // DATAS
    final formatterDMY = DateFormat('dd/MM/yyyy');
    // validadeOfertaInicioController = TextEditingController();
    final String? offerExpirationText = widget.product.offerExpiration != null
        ? formatterDMY.format(DateTime.parse(widget.product.offerExpiration!))
        : null;
    validadeOfertaFimController =
        TextEditingController(text: offerExpirationText);

    //IMAGES
    image = widget.product.imageUrl != null
        ? File.fromUri(Uri(path: widget.product.imageUrl!))
        : null;
  }

  void disposeTextControllers() {
    categoriaController.dispose();
    descricaoController.dispose();
    // pesoLiquidoController.dispose();
    // dataValidadeController.dispose();
    valorDeController.dispose();
    valorParaController.dispose();
    // validadeOfertaInicioController.dispose();
    validadeOfertaFimController.dispose();
  }

  Future initialize({bool tryAgain = false}) async {
    if (tryAgain) {
      setState(() {
        isLoading = true;
      });
    }

    _categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);

    await _categoriesProvider.getCategories();

    setState(() {
      setTextControllers();
      isLoading = false;
    });
  }

  Widget _buildContent(List<CategoryModel> categoriesList) {
    return RefreshIndicator(
      onRefresh: () => initialize(tryAgain: true),
      backgroundColor: AppScheme.white,
      color: AppScheme.brightGreen,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAutocompleteWidget(
                label: 'Categoria',
                initialValue: categoriaController.value,
                possibleOptions:
                    categoriesList.map((item) => item.name).toList(),
                onSelected: (value) =>
                    setState(() => categoriaController.text = value),
              ),
              const SizedBox(height: 15),
              LabeledOutlineTextFieldWidget(
                controller: descricaoController,
                label: 'Descrição',
              ),
              const SizedBox(height: 15),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(
              //       child: LabeledOutlineTextFieldWidget(
              //         controller: pesoLiquidoController,
              //         keyboardType: TextInputType.number,
              //         label: 'Peso Líquido',
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     Expanded(
              //       child: LabeledOutlineDatePicker(
              //         controller: dataValidadeController,
              //         label: 'Data de Validade',
              //         canPassMaxDate: true,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 5),
              // CheckboxListTileItemWidget(
              //   valor: naoTemValidade,
              //   titulo: 'Este produto não tem validade.',
              //   onChanged: (value) =>
              //       setState(() => naoTemValidade = value ?? false),
              // ),
              ProductContainerWidget(
                valorDeController: valorDeController,
                valorParaController: valorParaController,
                showOfferDates:
                    categoriaController.text != 'Serviços' && !naoTemValidade,
                validadeOfertaInicioController: null,
                validadeOfertaFimController: validadeOfertaFimController,
                image: image,
                selectImage: _selectImage,
              ),
              Visibility(
                visible: !sendingRequest,
                replacement: const CustomCircularProgressIndicator(),
                child: FilledButton(
                  onPressed: () => _onPressed(categoriesList),
                  child: const Text('Editar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _selectImage() async {
    final imageSource = await chooseGalleryCameraDialog(context);
    if (imageSource == null) return;

    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: imageSource);
    if (imageFile == null) return;

    setState(() => image = File(imageFile.path));
  }

  Future _onPressed(List<CategoryModel> categories) async {
    primaryFocus?.unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (!validateCategoryController(categoriaController, categories)) {
      return showDialog(
        context: context,
        builder: (context) =>
            PopupErrorWidget(content: 'Selecione uma Categoria!'),
      );
    }

    if (image == null) {
      return showDialog(
        context: context,
        builder: (context) =>
            PopupErrorWidget(content: 'Selecione uma imagem do Produto!'),
      );
    }

    try {
      setState(() => sendingRequest = true);
      // <ENVIO DA IMAGEM>
      final ProductProvider productProvider =
          Provider.of(context, listen: false);

      String? imageUrl = widget.product.imageUrl;
      if (imageUrl == null || !imageUrl.contains('https://')) {
        final responseImage =
            await sendProductImage(context, image!, 'product');

        if (responseImage == null) return;

        imageUrl = responseImage.url;

        if (!mounted) return;
      }
      // </ENVIO DA IMAGEM>

      // <ATUALIZANDO PRODUTO>
      final String auxParsedDate =
          naoTemValidade || validadeOfertaFimController.text.isEmpty
              ? DateFormat('dd/MM/yyyy').format(DateTime.now())
              : validadeOfertaFimController.text;

      final formattedDateTime = DateFormat('dd/MM/yyyy')
          .parse(auxParsedDate)
          .add(Duration(days: naoTemValidade ? 1 : 0));

      final patchedProductJson =
          await productProvider.patchProduct(widget.product.id, {
        "categoryId": widget.categoryId,
        "name": descricaoController.text,
        "originalPrice": num.parse(valorDeController.text),
        "offerPrice": num.parse(valorParaController.text),
        "offerExpiration": DateFormat('yyyy-MM-dd').format(formattedDateTime),
        "imageUrl": imageUrl,
      });

      if (!mounted) return;

      if (productProvider.hasError) {
        return showDialog(
          context: context,
          builder: (context) =>
              PopupErrorWidget(content: productProvider.errorMessage),
        );
      }

      final ProductsEstablishmentProvider productsEstablishmentProvider =
          Provider.of(context, listen: false);
      productsEstablishmentProvider.patchProductFromList(widget.product.id,
          widget.categoryId, ProductModel.fromJson(patchedProductJson!));
      // </ATUALIZANDO PRODUTO>

      await showDialog(
        context: context,
        builder: (context) => const PopupErrorWidget(
          title: 'Sucesso!',
          content: 'O produto foi editado com sucesso!',
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
      setState(() => sendingRequest = false);
    }
  }
}
