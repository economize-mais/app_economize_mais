import 'dart:io';

import 'package:app_economize_mais/models/category_model.dart';
import 'package:app_economize_mais/providers/categories_provider.dart';
import 'package:app_economize_mais/providers/product_provider.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

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
  bool hasntExpirationDate = false;

  bool isLoading = true;
  bool sendingRequest = false;

  @override
  void initState() {
    super.initState();

    setTextControllers();
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
        applyLeading: false,
        title: 'Anúncio',
        hideActions: true,
      ),
      body: Consumer<CategoriesProvider>(builder: (context, provider, child) {
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
      }),
    );
  }

  void setTextControllers() {
    _formKey = GlobalKey<FormState>();

    categoriaController = TextEditingController();
    descricaoController = TextEditingController();
    pesoLiquidoController = TextEditingController();
    productExpirationDateController = TextEditingController();
    valorDeController = TextEditingController();
    valorParaController = TextEditingController();
    offerStartDateController = TextEditingController();
    offerExpirationDateController = TextEditingController();
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

    setState(() => isLoading = false);
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
              const SizedBox(height: 5),
              CheckboxListTileItemWidget(
                valor: hasntExpirationDate,
                titulo: 'Este produto não tem validade.',
                onChanged: (value) =>
                    setState(() => hasntExpirationDate = value ?? false),
              ),
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
                  child: const Text('Postar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetWeightAndOfferDate() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Expanded(
          child: LabeledOutlineTextFieldWidget(
            controller: pesoLiquidoController,
            keyboardType: TextInputType.number,
            label: 'Peso Líquido',
            inputFormatters: [
              CurrencyTextInputFormatter.currency(
                locale: 'pt_BR',
                symbol: '',
                decimalDigits: 2,
              ),
            ],
          ),
        ),
        if (!hasntExpirationDate)
          Expanded(
            child: LabeledOutlineDatePicker(
              controller: productExpirationDateController,
              label: 'Data de Validade',
              canPassMaxDate: true,
            ),
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

    try {
      setState(() => sendingRequest = true);
      // <ENVIO DA IMAGEM>
      final ProductProvider productProvider =
          Provider.of(context, listen: false);

      final responseImage = await sendProductImage(context, image!, 'product');

      if (responseImage == null) return;

      if (!mounted) return;
      // </ENVIO DA IMAGEM>

      // <CRIANDO PRODUTO>
      final String categoryId = _categoriesProvider.categoriesList
          .firstWhere((item) => item.name == categoriaController.text)
          .id;

      final [
        parsedProductExpirationDate,
        parsedOfferStartDate,
        parsedOfferExpirationDate
      ] = formatStringDatesToYMD([
        productExpirationDateController.text,
        offerStartDateController.text,
        offerExpirationDateController.text,
      ]);

      await productProvider.postProduct({
        "categoryId": categoryId,
        "name": descricaoController.text,
        "originalPrice": num.parse(
            valorDeController.text.replaceAll('.', '').replaceAll(',', '.')),
        "offerPrice": num.parse(
            valorParaController.text.replaceAll('.', '').replaceAll(',', '.')),
        "offerStartDate": parsedOfferStartDate.isNotEmpty
            ? parsedOfferStartDate
            : DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "offerExpiration": parsedOfferExpirationDate.isNotEmpty
            ? parsedOfferExpirationDate
            : DateFormat('yyyy-MM-dd')
                .format(DateTime.now().add(Duration(days: 1))),
        "productExpirationDate": parsedProductExpirationDate.isNotEmpty
            ? parsedProductExpirationDate
            : null,
        "imageUrl": responseImage.url,
      });

      if (!mounted) return;

      if (productProvider.hasError) {
        return showDialog(
          context: context,
          builder: (context) =>
              PopupErrorWidget(content: productProvider.errorMessage),
        );
      }
      // </CRIANDO PRODUTO>

      await showDialog(
        context: context,
        builder: (context) => const PopupErrorWidget(
          title: 'Sucesso!',
          content: 'O produto foi cadastrado com sucesso!',
        ),
      );

      clearAllFields();
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
