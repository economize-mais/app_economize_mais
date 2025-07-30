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
              children: [
                Text(
                  'Você pode realizar a troca da senha acessando o seu Perfil no aplicativo localizado no canto inferior direito da tela, e clicar em TROCAR SENHA. Caso não lembre sua senha antiga, basta sair do aplicativo e, na página inicial do aplicativo, selecionar “Esqueci minha senha” . Um link será enviado ao seu e-mail cadastrado para a criação de uma nova senha.',
                ),
              ],
            ),
            CustomExpansionTileWidget(
              paddingBottom: 10,
              title: 'Como faço para cadastrar um alerta?',
              children: [
                Text(
                  'Basta acessar a página de alertas clicando no botão localizado no centro da barra inferior de comandos com o nome “Alertas”. Ao acessar a página de alertas, digite no campo “Digite Produto Buscado” , e o produto que você deseja, em seguida clique no botão “Criar Alerta”. Após criado o alerta, você será notificado assim que o produto entrar em promoção em um dos estabelecimentos cadastrados. ',
                ),
              ],
            ),
            CustomExpansionTileWidget(
              paddingBottom: 10,
              title: 'Desejo anunciar, como devo fazer?',
              children: [
                Text(
                  'Se você possui um estabelecimento comercial com loja física e deseja anunciar com a gente, clique AQUI (Link no aqui) e você será redirecionado à página onde colocará os dados de seu estabelecimento, e uma mensagem, que será enviada diretamente a um dos nossos atendentes, em seguida entraremos em contato com o número de telefone informado em até 72 horas.',
                ),
              ],
            ),
            CustomExpansionTileWidget(
              paddingBottom: 10,
              title: 'Como cadastrar mais de um endereço?',
              children: [
                Text(
                  'Não é possível cadastrar mais de um endereço, mas é possível mudar sua localização no aplicativo. Vá até a página principal, clique no nome da cidade localizado no canto superior direito e selecione uma nova cidade.',
                ),
              ],
            ),
            CustomExpansionTileWidget(
              paddingBottom: 10,
              title: 'Onde posso comprar os produtos anunciados?',
              children: [
                Text(
                  'Os produtos anunciados no Economize + somente estarão disponíveis nas lojas físicas dos anunciantes parceiros, não sendo possível comprar online.',
                ),
              ],
            ),
            CustomExpansionTileWidget(
              paddingBottom: 10,
              title:
                  'Fui comprar o produto e já não tinha mais no estoque, o que fazer?',
              children: [
                Text(
                  'A responsabilidade dos estoques disponíveis é do estabelecimento anunciante. Caso algum produto anunciado não esteja mais disponível, recomendamos aos usuários alertar o estabelecimento para que a oferta seja retirada do aplicativo.',
                ),
              ],
            ),
            CustomExpansionTileWidget(
              paddingBottom: 10,
              title:
                  'Por que preciso validar meu telefone, e-mail e dados pessoais?',
              children: [
                Text(
                  'A validação do e-mail e telefone se fazem necessários para que você passe a ser um usuário confiável pelo aplicativo Economize +. Além disso, permite que sejamos mais efetivos caso seja necessário algum tipo de contato com você, como por exemplo, caso esqueça sua senha.',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('E meus dados pessoais?'),
                  ),
                ),
                Text(
                  'É necessária a identificação formal do usuário para a maior segurança de todas as partes, mas não se preocupe, seus dados estarão sempre protegidos seguindo a Lei Geral de Proteção de dados, Lei nº 13.709/2018.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
