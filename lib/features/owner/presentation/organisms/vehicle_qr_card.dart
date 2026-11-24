import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../atoms/section_label.dart';
import '../atoms/surface_card.dart';
import '../owner_tokens.dart';

/// Card with the vehicle QR code and the text it encodes.
class VehicleQrCard extends StatelessWidget {
  const VehicleQrCard({
    super.key,
    required this.title,
    required this.payload,
    this.size = 180,
  });

  final String title;
  final String payload;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(title),
          const SizedBox(height: OwnerMetrics.gap),
          Center(
            child: QrImageView(
              data: payload,
              size: size,
              backgroundColor: OwnerColors.surface,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: OwnerColors.textPrimary,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: OwnerColors.textPrimary,
              ),
              semanticsLabel: 'Vehicle QR code',
            ),
          ),
          const SizedBox(height: OwnerMetrics.gap),
          Center(
            child: Text(
              payload,
              textAlign: TextAlign.center,
              style: OwnerText.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
