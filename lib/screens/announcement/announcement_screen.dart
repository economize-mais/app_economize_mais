import 'dart:io';

import 'package:app_economize_mais/models/category_model.dart';
import 'package:app_economize_mais/providers/categories_provider.dart';
import 'package:app_economize_mais/providers/product_provider.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_date_picker_widget.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:app_economize_mais/utils/widgets/tentar_novamente_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/announcement/widgets/product_container_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_dropdown_widget.dart';
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
  late TextEditingController dataValidadeController;
  late TextEditingController valorDeController;
  late TextEditingController valorParaController;
  late TextEditingController validadeOfertaInicioController;
  late TextEditingController validadeOfertaFimController;
  late GlobalKey<FormState> _formKey;
  File? image;

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
    descricaoController = TextEditingController(text: 'Quilo de Carne Moída');
    pesoLiquidoController = TextEditingController(text: '1000');
    dataValidadeController = TextEditingController(text: '27/11/2025');
    valorDeController = TextEditingController(text: '30');
    valorParaController = TextEditingController(text: '20');
    validadeOfertaInicioController = TextEditingController(text: '20/11/2025');
    validadeOfertaFimController = TextEditingController(text: '27/11/2025');
  }

  void disposeTextControllers() {
    categoriaController.dispose();
    descricaoController.dispose();
    pesoLiquidoController.dispose();
    dataValidadeController.dispose();
    valorDeController.dispose();
    valorParaController.dispose();
    validadeOfertaInicioController.dispose();
    validadeOfertaFimController.dispose();
  }

  void clearAllFields() {
    setState(() {
      categoriaController.clear();
      descricaoController.clear();
      pesoLiquidoController.clear();
      dataValidadeController.clear();
      valorDeController.clear();
      valorParaController.clear();
      validadeOfertaInicioController.clear();
      validadeOfertaFimController.clear();
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
      backgroundColor: AppScheme.white,
      color: AppScheme.brightGreen,
      onRefresh: () => initialize(tryAgain: true),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LabeledDropdownWidget(
                controller: categoriaController,
                label: 'Categoria',
                value: categoriaController.text,
                items: [
                  '',
                  ...categoriesList.map((item) => item.name),
                ],
                onChanged: (value) =>
                    setState(() => categoriaController.text = value ?? ''),
              ),
              const SizedBox(height: 15),
              LabeledOutlineTextFieldWidget(
                controller: descricaoController,
                label: 'Descrição',
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: LabeledOutlineTextFieldWidget(
                      controller: pesoLiquidoController,
                      label: 'Peso Líquido',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: LabeledOutlineDatePicker(
                      controller: dataValidadeController,
                      label: 'Data de Validade',
                      canPassMaxDate: true,
                    ),
                  ),
                ],
              ),
              ProductContainerWidget(
                valorDeController: valorDeController,
                valorParaController: valorParaController,
                showValidade: categoriaController.text != 'Serviços',
                validadeOfertaInicioController: validadeOfertaInicioController,
                validadeOfertaFimController: validadeOfertaFimController,
                image: image,
                selectImage: _selectImage,
              ),
              Visibility(
                visible: !sendingRequest,
                replacement: const CustomCircularProgressIndicator(),
                child: FilledButton(
                  onPressed: _onPressed,
                  child: const Text('Postar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _selectImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;

    setState(() => image = File(imageFile.path));
  }

  Future _onPressed() async {
    primaryFocus?.unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (categoriaController.text == '') {
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
      final responseImage =
          await productProvider.uploadImage(image!, 'product');

      if (!mounted) return;

      if (productProvider.hasError) {
        return showDialog(
          context: context,
          builder: (context) =>
              PopupErrorWidget(content: productProvider.errorMessage),
        );
      }
      // </ENVIO DA IMAGEM>

      // <CRIANDO PRODUTO>
      final String categoryId = _categoriesProvider.categoriesList
          .firstWhere((item) => item.name == categoriaController.text)
          .id;
      final formattedDateTime =
          DateFormat('dd/MM/yyyy').parse(validadeOfertaFimController.text);
      await productProvider.postProduct({
        "categoryId": categoryId,
        "name": descricaoController.text,
        "originalPrice": num.parse(valorDeController.text),
        "offerPrice": num.parse(valorParaController.text),
        "offerExpiration": DateFormat('yyyy-MM-dd').format(formattedDateTime),
        "imageUrl": responseImage!.url,
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
