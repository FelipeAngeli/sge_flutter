import 'package:flutter/material.dart';

import 'home_card_button.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(context),
          _buildModuleSection(
            context,
            'Operações',
            [
              const HomeCardButton(
                title: 'Registrar Venda',
                icon: Icons.point_of_sale,
                route: '/venda',
                color: Color(0xFF3949AB),
              ),
              const HomeCardButton(
                title: 'Produtos',
                icon: Icons.inventory_2,
                route: '/produtos',
                color: Color(0xFF5C6BC0),
              ),
              const HomeCardButton(
                title: 'Estoque',
                icon: Icons.warehouse,
                route: '/estoque',
                color: Color(0xFF7986CB),
              ),
            ],
          ),
          _buildModuleSection(
            context,
            'Gestão',
            [
              const HomeCardButton(
                title: 'Financeiro',
                icon: Icons.point_of_sale,
                route: '/financeiro',
                color: Color(0xFF3F51B5),
              ),
              const HomeCardButton(
                title: 'Relatórios',
                icon: Icons.assessment,
                route: '/relatorios',
                color: Color(0xFF303F9F),
              ),
              const HomeCardButton(
                title: 'Clientes',
                icon: Icons.person,
                route: '/clientes',
                color: Color(0xFF283593),
              ),
            ],
          ),
          _buildModuleSection(
            context,
            'Documentos',
            [
              const HomeCardButton(
                title: 'Recibos',
                icon: Icons.receipt_long,
                route: '/recibo',
                color: Color(0xFF1A237E),
              ),
              const HomeCardButton(
                title: 'Usuários',
                icon: Icons.people,
                route: '/users',
                color: Color(0xFF0D47A1),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1A237E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bem-vindo ao SGE',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Gerencie sua empresa de forma eficiente',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleSection(
    BuildContext context,
    String title,
    List<Widget> cards,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
            children: cards,
          ),
        ],
      ),
    );
  }
}
