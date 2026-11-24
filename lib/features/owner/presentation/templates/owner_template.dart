import 'package:flutter/material.dart';

import '../owner_tokens.dart';

/// Layout only: a header on top and a padded, scrollable body under it.
class OwnerTemplate extends StatelessWidget {
  const OwnerTemplate({super.key, required this.header, required this.body});

  final Widget header;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnerColors.background,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  OwnerMetrics.screenH,
                  OwnerMetrics.gap,
                  OwnerMetrics.screenH,
                  OwnerMetrics.xl,
                ),
                child: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
