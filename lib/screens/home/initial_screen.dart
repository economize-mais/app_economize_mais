import 'package:app_economize_mais/providers/establishments_provider.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/tentar_novamente_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/home/widgets/destaques_semana_widget.dart';
import 'package:app_economize_mais/screens/home/widgets/establishment_types_list_view_widget.dart';
import 'package:app_economize_mais/utils/widgets/filter_search_text_field_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late EstablishmentsProvider _establishmentsProvider;

  bool carregando = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        applyLeading: false,
        centerTitle: true,
        title: SizedBox(
          width: kToolbarHeight + 32,
          height: kToolbarHeight,
          child: Image.asset(
            'assets/icons/logo-preto.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        hideActions: false,
      ),
      body: Consumer<EstablishmentsProvider>(
        builder: (context, provider, child) {
          if (carregando) {
            return CustomCircularProgressIndicator(
              text: 'Buscando estabelecimentos...',
            );
          }

          if (provider.hasError) {
            return TentarNovamenteWidget(
              title:
                  'Não foi possível buscar os estabelecimentos. Por favor, tente novamente.',
              onPressed: () => initialize(tryAgain: true),
            );
          }

          return _buildContent(provider.establishmentsList);
        },
      ),
    );
  }

  Future initialize({bool tryAgain = false}) async {
    if (tryAgain) {
      setState(() => carregando = true);
    }

    _establishmentsProvider = Provider.of(context, listen: false);

    await _establishmentsProvider.getEstablishmentsList();

    setState(() => carregando = false);
  }

  Widget _buildContent(List establishmentsList) {
    return RefreshIndicator(
      onRefresh: () => initialize(tryAgain: true),
      backgroundColor: AppScheme.white,
      color: AppScheme.brightGreen,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FilterSearchTextFieldWidget(),
            const SizedBox(height: 15),
            const DestaquesSemanaWidget(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: establishmentsList.length,
              itemBuilder: (context, index) => EstablishmentTypesListViewWidget(
                  establishmentTypes: establishmentsList[index]),
            ),
          ],
        ),
      ),
    );
  }
}
