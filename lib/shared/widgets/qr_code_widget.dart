import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidget extends StatelessWidget {
  final String link;

  const QRCodeWidget({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: link,
      version: QrVersions.auto,
      size: 150.0,
    );
  }
}
