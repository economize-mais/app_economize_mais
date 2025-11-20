import 'package:app_economize_mais/utils/functions/verify_age.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app_economize_mais/utils/widgets/labeled_dropdown_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_date_picker_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';
import 'package:app_economize_mais/utils/widgets/text_button_with_icon_widget.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController nomeCompletoController;
  late TextEditingController cpfController;
  late TextEditingController telefoneController;
  late TextEditingController emailController;
  late TextEditingController dataNascimentoController;
  late TextEditingController generoController;

  final List<String> listaGeneros = ['Feminino', 'Masculino', 'Outro'];

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    nomeCompletoController = TextEditingController(text: 'Teste 2');
    cpfController = TextEditingController(text: '265.138.550-63');
    telefoneController = TextEditingController(text: '(35) 9 9999-9999');
    emailController = TextEditingController(text: 'teste2@teste.com');
    dataNascimentoController = TextEditingController(text: '17/12/1998');
    generoController = TextEditingController(text: listaGeneros[0]);
  }

  @override
  void dispose() {
    super.dispose();

    nomeCompletoController.dispose();
    cpfController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    dataNascimentoController.dispose();
    generoController.dispose();
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Insira seus dados para criar a sua conta',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  LabeledOutlineTextFieldWidget(
                    controller: nomeCompletoController,
                    label: 'Nome Completo',
                    paddingTop: 15,
                  ),
                  LabeledOutlineTextFieldWidget(
                    controller: cpfController,
                    label: 'CPF',
                    paddingTop: 15,
                    inputFormatters: [
                      MaskTextInputFormatter(
                          mask: "###.###.###-##",
                          filter: {"#": RegExp(r'[0-9]')})
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  LabeledOutlineTextFieldWidget(
                    controller: telefoneController,
                    label: 'Telefone',
                    paddingTop: 15,
                    inputFormatters: [
                      MaskTextInputFormatter(
                          mask: "(##) # ####-####",
                          filter: {"#": RegExp(r'[0-9]')})
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  LabeledOutlineTextFieldWidget(
                    controller: emailController,
                    label: 'Email',
                    paddingTop: 15,
                    paddingBottom: 15,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: LabeledOutlineDatePicker(
                          controller: dataNascimentoController,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: LabeledDropdownWidget(
                          controller: generoController,
                          value: generoController.text,
                          items: listaGeneros,
                          label: 'Gênero',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  TextButtonWithIconWidget(
                    onPressed: adicionarEndereco,
                    label: 'Adicionar Endereço',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void adicionarEndereco() {
    if (!formKey.currentState!.validate()) return;
    nomeCompletoController.text = nomeCompletoController.text.trim();
    emailController.text = emailController.text.trim();
    cpfController.text = cpfController.text
        .replaceAll('.', '')
        .replaceAll('/', '')
        .replaceAll('-', '');

    final birthDate =
        dataNascimentoController.text.split('/').reversed.join('-');
    final isAdult = is18YearsOld(birthDate);

    if (!isAdult) {
      showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(
          content:
              "Você precisa ser maior de 18 anos para acessar o aplicativo.",
        ),
      );
      return;
    }

    final userJson = {
      'email': emailController.text,
      'name': nomeCompletoController.text,
      'birthDate': birthDate,
      'cpf': cpfController.text,
      'phone': telefoneController.text,
      'gender': generoController.text[0],
    };

    Navigator.pushNamed(context, '/cadastro/endereco', arguments: {
      'userJson': userJson,
    });
  }
}
