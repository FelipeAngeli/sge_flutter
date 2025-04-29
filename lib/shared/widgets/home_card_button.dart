// lib/shared/widgets/home_card_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeCardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const HomeCardButton({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Modular.to.navigate(route),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50),
              const SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
