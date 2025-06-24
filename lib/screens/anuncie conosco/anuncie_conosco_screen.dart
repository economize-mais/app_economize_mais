import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_dropdown_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class AnuncieConoscoScreen extends StatelessWidget {
  const AnuncieConoscoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nomeFantasiaController =
        TextEditingController();
    final TextEditingController tipoComercioController =
        TextEditingController();
    final TextEditingController cnpjController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController telefoneController = TextEditingController();
    final TextEditingController mensagemController = TextEditingController();

    return Scaffold(
      appBar: const GeneralAppBar(
        title: 'Anuncie Conosco',
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
              Text(
                'Faça parte do Economize+ e anuncie suas ofertas para milhares de pessoas!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppScheme.gray[4],
                  fontSize: 14,
                ),
              ),
              LabeledOutlineTextFieldWidget(
                controller: nomeFantasiaController,
                label: 'Nome Fantasia',
                paddingTop: 25,
                paddingBottom: 15,
              ),
              LabeledDropdownWidget(
                controller: tipoComercioController,
                value: tipoComercioController.text.isEmpty
                    ? 'Supermercados'
                    : tipoComercioController.text,
                items: const [
                  'Supermercados',
                  'Farmácias',
                  'Hortifrutis',
                  'Cosméticos',
                  'Lojas',
                  'Outros'
                ],
                label: 'Tipo de Comércio',
              ),
              const SizedBox(height: 15),
              LabeledOutlineTextFieldWidget(
                controller: cnpjController,
                label: 'CNPJ',
                paddingBottom: 15,
              ),
              LabeledOutlineTextFieldWidget(
                controller: emailController,
                label: 'Email',
                paddingBottom: 15,
              ),
              LabeledOutlineTextFieldWidget(
                controller: telefoneController,
                label: 'Telefone',
                paddingBottom: 15,
              ),
              LabeledOutlineTextFieldWidget(
                controller: mensagemController,
                label: 'Mensagem',
                maxLines: 5,
                paddingBottom: 25,
              ),
              FilledButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  showDialog(
                    context: context,
                    barrierColor: AppScheme.white.withOpacity(0.7),
                    builder: (context) => AlertDialog(
                      backgroundColor: AppScheme.white,
                      elevation: 2,
                      shadowColor: AppScheme.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: AppScheme.lightGray),
                      ),
                      icon: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close, size: 20),
                        ),
                      ),
                      iconPadding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      title: const Text('Nova senha enviada por e-mail.'),
                      titlePadding: const EdgeInsets.fromLTRB(40, 0, 40, 30),
                    ),
                  ).then((_) => Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      ));
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
