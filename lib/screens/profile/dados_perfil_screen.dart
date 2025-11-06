import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/screens/profile/functions/text_formatters.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/labeled_dropdown_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_date_picker_widget.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class DadosPerfilScreen extends StatefulWidget {
  const DadosPerfilScreen({super.key});

  @override
  State<DadosPerfilScreen> createState() => _DadosPerfilScreenState();
}

class _DadosPerfilScreenState extends State<DadosPerfilScreen> {
  late UsuarioProvider usuarioProvider;

  late bool isUser;
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController cpfController;
  late TextEditingController tradeNameController;
  late TextEditingController phoneController;
  late TextEditingController birthDateController;
  late TextEditingController genderController;

  final List<String> listaGeneros = ['Feminino', 'Masculino', 'Outro'];
  bool loading = false;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();

    usuarioProvider = Provider.of(context, listen: false);
    final userModel = usuarioProvider.userModel!;
    isUser = userModel.type == 'USER';

    nameController = TextEditingController(
        text: isUser ? userModel.name : userModel.companyName);
    cpfController =
        TextEditingController(text: cpfFormatter(userModel.cpf, isUser));
    tradeNameController = TextEditingController(text: userModel.tradeName);
    phoneController =
        TextEditingController(text: phoneFormatter(userModel.phone));

    final formatterYmd = DateFormat('dd/MM/yyyy');
    birthDateController = TextEditingController(
      text: userModel.birthDate != null
          ? formatterYmd.format(DateTime.parse(userModel.birthDate!))
          : userModel.birthDate,
    );

    genderController = TextEditingController(
        text: listaGeneros.firstWhere((item) => item[0] == userModel.gender));
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    cpfController.dispose();
    tradeNameController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    genderController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fields = isUser ? _userFields() : _companyFields();

    return Scaffold(
      appBar: GeneralAppBar(
        title: 'Dados ${isUser ? 'Pessoais' : 'da Empresa'}',
        hideActions: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LabeledOutlineTextFieldWidget(
                controller: nameController,
                label: isUser ? 'Nome Completo' : 'Razão Social',
                paddingBottom: 15,
              ),
              ...fields,
              const SizedBox(height: 25),
              Visibility(
                visible: !loading,
                replacement: const CustomCircularProgressIndicator(),
                child: FilledButton(
                  onPressed: update,
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _userFields() {
    return [
      LabeledOutlineTextFieldWidget(
        controller: cpfController,
        label: 'CPF',
        paddingBottom: 15,
        inputFormatters: [
          MaskTextInputFormatter(
            mask: "###.###.###-##",
            filter: {"#": RegExp(r'[0-9]')},
          ),
        ],
        keyboardType: TextInputType.number,
      ),
      LabeledOutlineTextFieldWidget(
        controller: phoneController,
        label: 'Telefone',
        paddingBottom: 15,
        keyboardType: TextInputType.number,
        inputFormatters: [
          MaskTextInputFormatter(
            mask: "(##) # ####-####",
            filter: {"#": RegExp(r'[0-9]')},
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: LabeledOutlineDatePicker(
              controller: birthDateController,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: LabeledDropdownWidget(
              controller: genderController,
              value: genderController.text,
              items: listaGeneros,
              label: 'Gênero',
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _companyFields() {
    return [
      LabeledOutlineTextFieldWidget(
        controller: tradeNameController,
        label: 'Nome Fantasia',
        paddingBottom: 15,
      ),
      LabeledOutlineTextFieldWidget(
        controller: cpfController,
        label: 'CNPJ',
        inputFormatters: [
          MaskTextInputFormatter(
            mask: "##.###.###/####-##",
            filter: {"#": RegExp(r'[0-9]')},
          ),
        ],
      ),
      const SizedBox(height: 15),
      LabeledOutlineTextFieldWidget(
        controller: phoneController,
        label: 'Telefone',
        keyboardType: TextInputType.number,
        inputFormatters: [
          MaskTextInputFormatter(
            mask: "(##) # ####-####",
            filter: {"#": RegExp(r'[0-9]')},
          ),
        ],
      ),
    ];
  }

  Future update() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => loading = true);

    Map<String, dynamic> auxMap = usuarioProvider.userModel!.toJson();

    auxMap.remove('id');
    auxMap.remove('termsAcceptance');
    auxMap[isUser ? 'name' : 'companyName'] = nameController.text.trim();
    auxMap['cpf'] = cpfController.text
        .replaceAll('.', '')
        .replaceAll('/', '')
        .replaceAll('-', '');
    auxMap['tradeName'] =
        tradeNameController.text != '' ? tradeNameController.text : null;
    auxMap['phone'] = phoneController.text;
    auxMap['birthDate'] = birthDateController.text != ''
        ? birthDateController.text.split('/').reversed.join('-')
        : null;
    auxMap['gender'] =
        genderController.text != '' ? genderController.text[0] : null;

    try {
      await usuarioProvider.update(auxMap);
      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) => const PopupErrorWidget(
          title: 'Sucesso!',
          content: 'Usuário atualizado.',
        ),
      );
      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(
          content: usuarioProvider.errorMessage,
        ),
      );
    }

    setState(() => loading = false);
  }
}
