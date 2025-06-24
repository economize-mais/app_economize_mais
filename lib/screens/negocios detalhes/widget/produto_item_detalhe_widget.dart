import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:provider/provider.dart';

class ProdutoItemDetalheWidget extends StatelessWidget {
  final Map<String, dynamic> produto;

  const ProdutoItemDetalheWidget({
    super.key,
    required this.produto,
  });

  @override
  Widget build(BuildContext context) {
    final UsuarioProvider usuarioProvider = Provider.of(context, listen: false);

    return Scaffold(
      appBar: const GeneralAppBar(
        title: 'Produto',
        hideActions: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FadeInImage(
                    height: 230,
                    width: 268,
                    fit: BoxFit.contain,
                    placeholder: const AssetImage(
                      "assets/images/supermarket_placeholder.png",
                    ),
                    image: AssetImage(
                      "assets/images/supermercados/${produto['assetUrl']}",
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: AppScheme.brightGreen,
                      child: Text(
                        '${produto['desconto']} de desconto',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              produto['nome'],
              style: TextStyle(
                color: AppScheme.gray[4],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'Vencimento: ${produto['vencimento']}',
              style: const TextStyle(
                color: AppScheme.red,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'De: R\$${produto['precoAntigo']}',
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationColor: AppScheme.red,
                color: AppScheme.red,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 50,
              width: 150,
              padding: const EdgeInsets.all(6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppScheme.brightGreen,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'R\$ ${produto['precoComDesconto']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 80),
            if (usuarioProvider.userModel?.userType != 'USER')
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Editar'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Excluir'),
                    ),
                  ),
                ],
              ),
            const Spacer(),
            Text(
              'Vendas somente na loja',
              style: TextStyle(
                color: AppScheme.gray[4],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
