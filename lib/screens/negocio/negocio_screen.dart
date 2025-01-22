import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/home/widgets/negocio_card_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/filter_search_text_field_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';

class EmpresasScreen extends StatelessWidget {
  final Map negocios;

  const EmpresasScreen({
    super.key,
    required this.negocios,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: ''),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FilterSearchTextFieldWidget(),
            const SizedBox(height: 15),
            Text(
              negocios['grupo'],
              style: TextStyle(
                color: AppScheme.gray[4],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 10,
              runSpacing: 10,
              children: (negocios['empresas'] as List)
                  .map(
                    (e) => NegocioCardWidget(
                      empresa: e,
                      width: 100,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
