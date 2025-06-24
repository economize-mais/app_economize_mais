import 'package:flutter/material.dart';
import 'package:app_economize_mais/mock/produtos_itens_mock.dart';
import 'package:app_economize_mais/screens/home/widgets/destaques_semana_widget.dart';
import 'package:app_economize_mais/screens/home/widgets/negocios_list_view_widget.dart';
import 'package:app_economize_mais/utils/widgets/filter_search_text_field_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';

const listaEmpresas = [
  {
    'grupo': 'Supermercados',
    'empresas': [
      {
        'nome': 'Alvorada',
        'assetUrl': 'supermercados/alvorada.png',
        'tipo': 'Supermercado',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Unissul',
        'assetUrl': 'supermercados/unissul.png',
        'tipo': 'Supermercado',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Lacerda',
        'assetUrl': 'supermercados/lacerda.png',
        'tipo': 'Supermercado',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'São Paulo',
        'assetUrl': 'supermercados/saopaulo.png',
        'tipo': 'Supermercado',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Nobre',
        'assetUrl': 'supermercados/nobre.png',
        'tipo': 'Supermercado',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Pinheiros',
        'assetUrl': 'supermercados/pinheiros.png',
        'tipo': 'Supermercado',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Abc',
        'assetUrl': 'supermercados/abc.png',
        'tipo': 'Supermercado',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Mart Minas',
        'assetUrl': 'supermercados/martminas.png',
        'tipo': 'Supermercado',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Epa',
        'assetUrl': 'supermercados/epa.png',
        'tipo': 'Supermercado',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
    ],
  },
  {
    'grupo': 'Farmácias',
    'empresas': [
      {
        'nome': 'Natus Farma',
        'assetUrl': 'farmacias/natusfarma.png',
        'tipo': 'Farmacia',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Drogaria Santa Maria',
        'assetUrl': 'farmacias/santamaria.png',
        'tipo': 'Farmacia',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Farmácia Bernardes',
        'assetUrl': 'farmacias/bernardes.png',
        'tipo': 'Farmacia',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Drogasil',
        'assetUrl': 'farmacias/drogasil.png',
        'tipo': 'Farmacia',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Drogaria São Paulo',
        'assetUrl': 'farmacias/drogaria-saopaulo.png',
        'tipo': 'Farmacia',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Drogaria Araujo',
        'assetUrl': 'farmacias/araujo.png',
        'tipo': 'Farmacia',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'La Botica',
        'assetUrl': 'farmacias/botica.png',
        'tipo': 'Farmacia',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Alfenense',
        'assetUrl': 'farmacias/alfenense.png',
        'tipo': 'Farmacia',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
    ],
  },
  {
    'grupo': 'Hortifrutis',
    'empresas': [
      {
        'nome': "Hortifruti D'Avó",
        'assetUrl': 'hortifrutis/davo.png',
        'tipo': 'Hortifruti',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Hortifruti Da Lu',
        'assetUrl': 'hortifrutis/hortifruti-da-lu.png',
        'tipo': 'Hortifruti',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Sacolão Center',
        'assetUrl': 'hortifrutis/sacolao.png',
        'tipo': 'Hortifruti',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
    ],
  },
  {
    'grupo': 'Cosméticos',
    'empresas': [
      {
        'nome': "O Boticário",
        'assetUrl': 'cosmeticos/boticario.png',
        'tipo': 'Cosméticos',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Casa do Cabeleireiro',
        'assetUrl': 'cosmeticos/casa-cabeleireiro.png',
        'tipo': 'Cosméticos',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
    ],
  },
  {
    'grupo': 'Lojas',
    'empresas': [
      {
        'nome': "Cacau Show",
        'assetUrl': 'lojas_servicos/cacaushow.png',
        'tipo': 'Lojas',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Brasil Cacau',
        'assetUrl': 'lojas_servicos/brasil-cacau.png',
        'tipo': 'Lojas',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Kopenhagen',
        'assetUrl': 'lojas_servicos/kopenhagen.png',
        'tipo': 'Lojas',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'SLD Nutrição Esportiva',
        'assetUrl': 'lojas_servicos/sld.png',
        'tipo': 'Lojas',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
      {
        'nome': 'Center Fitness Suplementos',
        'assetUrl': 'lojas_servicos/center-fitness.png',
        'tipo': 'Lojas',
        'unidade': 'Unidade 1',
        'endereco': 'Rua ABC, nº 123',
        'produtos': [
          produtosLimpezas,
          produtosCarnes,
          produtosPadarias,
          produtosHortifruti,
        ],
      },
    ],
  },
];

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FilterSearchTextFieldWidget(),
            const SizedBox(height: 15),
            const DestaquesSemanaWidget(),
            ...listaEmpresas.map((item) => NegociosListViewWidget(
                  negocios: item,
                )),
          ],
        ),
      ),
    );
  }
}
