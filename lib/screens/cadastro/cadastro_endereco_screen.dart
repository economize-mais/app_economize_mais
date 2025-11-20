import 'dart:async';

import 'package:app_economize_mais/models/zipcode_model.dart';
import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/utils/functions/get_user_location.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/formatters/uppercase_text_formatter.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';
import 'package:provider/provider.dart';

class CadastroEnderecoScreen extends StatefulWidget {
  final Map<String, dynamic> userJson;

  const CadastroEnderecoScreen({
    super.key,
    required this.userJson,
  });

  @override
  State<CadastroEnderecoScreen> createState() => _CadastroEnderecoScreenState();
}

class _CadastroEnderecoScreenState extends State<CadastroEnderecoScreen> {
  late UsuarioProvider usuarioProvider;

  late GlobalKey<FormState> formKey;
  late TextEditingController cepController;
  late TextEditingController ruaController;
  late TextEditingController numeroController;
  late TextEditingController bairroController;
  late TextEditingController cidadeController;
  late TextEditingController ufController;
  late TextEditingController complementoController;

  bool loadingLocation = false;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    usuarioProvider = Provider.of(context, listen: false);

    formKey = GlobalKey<FormState>();
    cepController = TextEditingController();
    ruaController = TextEditingController();
    numeroController = TextEditingController();
    bairroController = TextEditingController();
    cidadeController = TextEditingController();
    ufController = TextEditingController();
    complementoController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) => getCurrentLocation());
  }

  @override
  void dispose() {
    super.dispose();

    cepController.dispose();
    ruaController.dispose();
    numeroController.dispose();
    bairroController.dispose();
    cidadeController.dispose();
    ufController.dispose();
    complementoController.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Adicione seu endereço para criar a sua conta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppScheme.gray[4],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 4,
                        child: KeyboardListener(
                          focusNode: FocusNode(),
                          onKeyEvent: onKeyEvent,
                          child: LabeledOutlineTextFieldWidget(
                            controller: cepController,
                            label: 'CEP',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              MaskTextInputFormatter(
                                mask: "#####-###",
                                filter: {'#': RegExp(r'[0-9]')},
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: !loadingLocation ? getCurrentLocation : null,
                        iconSize: 30,
                        icon: !loadingLocation
                            ? const Icon(Icons.location_on)
                            : const CustomCircularProgressIndicator(size: 30),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  LabeledOutlineTextFieldWidget(
                    controller: ruaController,
                    label: 'Rua/Avenida/Travessia',
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: LabeledOutlineTextFieldWidget(
                          controller: numeroController,
                          label: 'Número',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: LabeledOutlineTextFieldWidget(
                          controller: bairroController,
                          label: 'Bairro',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LabeledOutlineTextFieldWidget(
                          controller: cidadeController,
                          label: 'Cidade',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: LabeledOutlineTextFieldWidget(
                          controller: ufController,
                          label: 'UF',
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                            MaskTextInputFormatter(
                              mask: '##',
                              filter: {
                                '#': RegExp(r'[A-Z]'),
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  LabeledOutlineTextFieldWidget(
                    controller: complementoController,
                    label: 'Complemento',
                  ),
                  const SizedBox(height: 25),
                  FilledButton(
                    onPressed: continuar,
                    child: const Text('Continuar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getCurrentLocation() async {
    setState(() => loadingLocation = true);

    String locationZipcode = '';
    ZipcodeModel? zipcodeInfo;

    try {
      var latLong = await getUserLatLong();
      if (latLong is bool) {
        return;
      }

      var (latitude, longitude) = latLong;
      locationZipcode = await mapMostProbableZipcode(latitude, longitude);
      zipcodeInfo = await usuarioProvider.pegarCEP(locationZipcode);
    } catch (e) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => const PopupErrorWidget(
          content: 'Não foi possível pegar as informações de localização',
        ),
      );
    }

    setState(() {
      cepController.text = locationZipcode;

      if (zipcodeInfo != null) {
        ruaController.text = zipcodeInfo.street;
        bairroController.text = zipcodeInfo.neighborhood;
        cidadeController.text = zipcodeInfo.city;
        ufController.text = zipcodeInfo.state;
      }

      loadingLocation = false;
    });
  }

  Future onKeyEvent(KeyEvent keyEvent) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 700), () async {
      if (cepController.text.length != 9) return;
      final zipcode = await usuarioProvider.pegarCEP(cepController.text);
      if (zipcode == null) return;

      setState(() {
        ruaController.text = zipcode.street;
        bairroController.text = zipcode.neighborhood;
        cidadeController.text = zipcode.city;
        ufController.text = zipcode.state;
      });
    });
  }

  Future continuar() async {
    if (loadingLocation) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Espere até a localização seja concluída'),
      ));
      return;
    }

    if (!formKey.currentState!.validate()) return;
    ruaController.text = ruaController.text.trim();
    bairroController.text = bairroController.text.trim();
    cidadeController.text = cidadeController.text.trim();
    ufController.text = ufController.text.trim();
    complementoController.text = complementoController.text.trim();

    final userJson = {
      ...widget.userJson,
      'addresses': [
        {
          'street': ruaController.text,
          'number': numeroController.text,
          'neighborhood': bairroController.text,
          'city': cidadeController.text,
          'state': ufController.text,
          'complement': complementoController.text,
          'zipcode': cepController.text,
        },
      ],
    };

    Navigator.pushNamed(context, '/cadastro/senha', arguments: {
      'userJson': userJson,
    });
  }
}
