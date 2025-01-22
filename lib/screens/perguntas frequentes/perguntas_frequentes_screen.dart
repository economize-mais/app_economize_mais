import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/widgets/custom_expansion_tile_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';

class PerguntasFrequentesScreen extends StatelessWidget {
  const PerguntasFrequentesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GeneralAppBar(
        title: 'Perguntas Frequentes',
        hideActions: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomExpansionTileWidget(
              paddingBottom: 10,
              title: 'Como realizar a troca de senha?',
              children: [],
            ),
            CustomExpansionTileWidget(
              paddingBottom: 10,
              title: 'Como faço para cadastrar um alerta?',
              children: [],
            ),
            CustomExpansionTileWidget(
              paddingBottom: 10,
              title: 'Desejo anunciar, como devo fazer?',
              children: [],
            ),
            CustomExpansionTileWidget(
              title: 'Como cadastrar mais de um endereço?',
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
