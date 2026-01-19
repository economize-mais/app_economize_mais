import 'dart:io';

import 'package:app_economize_mais/models/category_model.dart';
import 'package:app_economize_mais/models/product_model.dart';
import 'package:app_economize_mais/providers/categories_provider.dart';
import 'package:app_economize_mais/providers/product_provider.dart';
import 'package:app_economize_mais/providers/products_establishment_provider.dart';
import 'package:app_economize_mais/screens/announcement/widgets/measurement_units_widget.dart';
import 'package:app_economize_mais/utils/functions/format_types.dart';
import 'package:app_economize_mais/utils/functions/product/send_product_image.dart';
import 'package:app_economize_mais/utils/functions/validate_category_controller.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/functions/choose_gallery_camera_dialog.dart';
import 'package:app_economize_mais/utils/widgets/checkbox_list_tile_item_widget.dart';
import 'package:app_economize_mais/utils/widgets/custom_autocomplete_widget.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_date_picker_widget.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:app_economize_mais/utils/widgets/tentar_novamente_widget.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/announcement/widgets/product_container_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AnnouncementScreen extends StatefulWidget {
  final ProductModel? product;
  final String? categoryId;

  const AnnouncementScreen({
    super.key,
    this.product,
    this.categoryId,
  });

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  late CategoriesProvider _categoriesProvider;

  late TextEditingController categoriaController;
  late TextEditingController descricaoController;
  late TextEditingController pesoLiquidoController;
  late TextEditingController productExpirationDateController;
  late TextEditingController valorDeController;
  late TextEditingController valorParaController;
  late TextEditingController offerStartDateController;
  late TextEditingController offerExpirationDateController;
  late GlobalKey<FormState> _formKey;
  File? image;
  bool productHasExpirationDate = true;
  int selectedUnitIndex = 0;
  List<String> units = const ['KG', 'LT'];

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
      appBar: GeneralAppBar(
        applyLeading: widget.product == null ? false : true,
        title: widget.product == null ? 'Anúncio' : 'Editar Anúncio',
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

    final String textCategoria = widget.categoryId != null
        ? _categoriesProvider.categoriesList
            .firstWhere((item) => item.id == widget.categoryId)
            .name
        : '';

    categoriaController = TextEditingController(text: textCategoria);
    descricaoController = TextEditingController(text: widget.product?.name);
    pesoLiquidoController = TextEditingController(
        text: widget.product?.weight?.replaceAll('.', ','));
    productExpirationDateController =
        TextEditingController(text: widget.product?.priceOriginal);

    valorDeController = TextEditingController(
        text: widget.product?.priceOriginal != null
            ? formatDecimalNumber(widget.product!.priceOriginal)
            : null);
    valorParaController = TextEditingController(
        text: widget.product?.priceOffer != null
            ? formatDecimalNumber(widget.product!.priceOffer)
            : null);

    // DATAS
    final formatterDMY = DateFormat('dd/MM/yyyy');

    final String? offerStartExpirationText = widget.product?.offerStartDate !=
            null
        ? formatterDMY.format(DateTime.parse(widget.product!.offerStartDate!))
        : null;

    offerStartDateController =
        TextEditingController(text: offerStartExpirationText);

    final String? offerExpirationText = widget.product?.offerExpiration != null
        ? formatterDMY.format(DateTime.parse(widget.product!.offerExpiration!))
        : null;
    offerExpirationDateController =
        TextEditingController(text: offerExpirationText);

    productHasExpirationDate = widget.product?.productHasExpirationDate ?? true;
    final String? productExpirationText = widget.product != null &&
            widget.product!.productHasExpirationDate &&
            widget.product!.productExpirationDate != null
        ? formatterDMY
            .format(DateTime.parse(widget.product!.productExpirationDate!))
        : null;
    productExpirationDateController =
        TextEditingController(text: productExpirationText);

    //IMAGES
    image = widget.product?.imageUrl != null
        ? File.fromUri(Uri(path: widget.product!.imageUrl!))
        : null;

    selectedUnitIndex = widget.product?.unitOfMeasure != null
        ? units.indexOf(widget.product!.unitOfMeasure!)
        : 0;
  }

  void disposeTextControllers() {
    categoriaController.dispose();
    descricaoController.dispose();
    pesoLiquidoController.dispose();
    productExpirationDateController.dispose();
    valorDeController.dispose();
    valorParaController.dispose();
    offerStartDateController.dispose();
    offerExpirationDateController.dispose();
  }

  void clearAllFields() {
    setState(() {
      categoriaController.clear();
      descricaoController.clear();
      pesoLiquidoController.clear();
      productExpirationDateController.clear();
      valorDeController.clear();
      valorParaController.clear();
      offerStartDateController.clear();
      offerExpirationDateController.clear();
      image = null;
    });
  }

  Future initialize({bool tryAgain = false}) async {
    if (tryAgain) {
      setState(() => isLoading = true);
    }

    _categoriesProvider = Provider.of(context, listen: false);

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
              _buildNetWeightAndOfferDate(),
              ProductContainerWidget(
                valorDeController: valorDeController,
                valorParaController: valorParaController,
                showOfferDates: categoriaController.text != 'Serviços',
                validadeOfertaInicioController: offerStartDateController,
                validadeOfertaFimController: offerExpirationDateController,
                image: image,
                selectImage: _selectImage,
              ),
              Visibility(
                visible: !sendingRequest,
                replacement: const CustomCircularProgressIndicator(),
                child: FilledButton(
                  onPressed: () => _onPressed(categoriesList),
                  child: Text(widget.product == null ? 'Postar' : 'Editar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetWeightAndOfferDate() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            Expanded(
              child: LabeledOutlineTextFieldWidget(
                controller: pesoLiquidoController,
                keyboardType: TextInputType.number,
                label: 'Peso Líquido',
                isOptional: true,
                inputFormatters: [
                  CurrencyTextInputFormatter.currency(
                    locale: 'pt_BR',
                    symbol: '',
                    decimalDigits: 3,
                  ),
                ],
              ),
            ),
            MeasurementUnitsWidget(
              selectedUnitIndex: selectedUnitIndex,
              units: units,
              onSelected: (value) => setState(() => selectedUnitIndex = value),
            ),
          ],
        ),
        CheckboxListTileItemWidget(
          valor: productHasExpirationDate,
          titulo: 'Este produto tem validade.',
          onChanged: (value) =>
              setState(() => productHasExpirationDate = value ?? false),
        ),
        if (productHasExpirationDate)
          LabeledOutlineDatePicker(
            controller: productExpirationDateController,
            label: 'Data de Validade',
            canPassMaxDate: true,
          ),
      ],
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

    final [
      parsedProductExpirationDate,
      parsedOfferStartDate,
      parsedOfferExpirationDate
    ] = formatStringDatesToYMD([
      productExpirationDateController.text,
      offerStartDateController.text,
      offerExpirationDateController.text,
    ]);

    final DateTime? dateTimeProductExpiration =
        parsedProductExpirationDate.isNotEmpty
            ? DateTime.parse(parsedProductExpirationDate)
            : null;
    final dateTimeOfferExpiration = DateTime.parse(parsedOfferExpirationDate);

    if (productHasExpirationDate &&
        dateTimeOfferExpiration.isAfter(dateTimeProductExpiration!)) {
      return showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(
            content:
                'A data final da validade da oferta não pode ser maior que a validade do produto!'),
      );
    }

    try {
      setState(() => sendingRequest = true);
      // <ENVIO DA IMAGEM>
      final ProductProvider productProvider =
          Provider.of(context, listen: false);

      String? imageUrl = widget.product?.imageUrl;
      if (imageUrl == null || !imageUrl.contains('https://')) {
        final responseImage =
            await sendProductImage(context, image!, 'product');

        if (responseImage == null) return;

        imageUrl = responseImage.url;

        if (!mounted) return;
      }
      // </ENVIO DA IMAGEM>

      // <CRIANDO OU ATUALIZANDO PRODUTO>
      final String categoryId = _categoriesProvider.categoriesList
          .firstWhere((item) => item.name == categoriaController.text)
          .id;

      num weight = pesoLiquidoController.text.trim().isNotEmpty
          ? num.parse(pesoLiquidoController.text
              .replaceAll('.', '')
              .replaceAll(',', '.'))
          : 0;

      num originalPrice = valorDeController.text.trim().isNotEmpty
          ? num.parse(
              valorDeController.text.replaceAll('.', '').replaceAll(',', '.'))
          : 0;

      num offerPrice = valorParaController.text.trim().isNotEmpty
          ? num.parse(
              valorParaController.text.replaceAll('.', '').replaceAll(',', '.'))
          : 0;

      final Map<String, dynamic> productMap = {
        "categoryId": categoryId,
        "name": descricaoController.text,
        "weight": weight,
        "unitOfMeasure": units[selectedUnitIndex],
        "originalPrice": originalPrice,
        "offerPrice": offerPrice,
        "offerStartDate": parsedOfferStartDate.isNotEmpty
            ? parsedOfferStartDate
            : DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "offerExpiration": parsedOfferExpirationDate.isNotEmpty
            ? parsedOfferExpirationDate
            : DateFormat('yyyy-MM-dd')
                .format(DateTime.now().add(Duration(days: 1))),
        "productHasExpirationDate": productHasExpirationDate,
        "productExpirationDate":
            parsedProductExpirationDate.isNotEmpty && productHasExpirationDate
                ? parsedProductExpirationDate
                : null,
        "imageUrl": imageUrl,
      };

      final result = widget.product == null
          ? await productProvider.postProduct(productMap)
          : await productProvider.patchProduct(widget.product!.id, productMap);

      if (!mounted) return;

      if (productProvider.hasError) {
        return showDialog(
          context: context,
          builder: (context) =>
              PopupErrorWidget(content: productProvider.errorMessage),
        );
      }
      if (widget.product != null) {
        final ProductsEstablishmentProvider productsEstablishmentProvider =
            Provider.of(context, listen: false);
        productsEstablishmentProvider.patchProductFromList(widget.product!.id,
            widget.categoryId!, ProductModel.fromJson(result!));
      }

      // </CRIANDO OU ATUALIZANDO PRODUTO>

      await showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(
          title: 'Sucesso!',
          content:
              'O produto foi ${widget.product == null ? 'cadastrado' : 'editado'} com sucesso!',
        ),
      );

      clearAllFields();

      if (!mounted) return;

      if (widget.product != null) {
        context.pop();
      }
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
