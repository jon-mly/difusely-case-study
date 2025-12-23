import 'package:easy_localization/easy_localization.dart';
import 'package:employees_app/presentation/style/radius.dart';
import 'package:employees_app/presentation/style/spacings.dart';
import 'package:employees_app/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.message});

  final String message;

  static void show(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ErrorDialog(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.shadow.withAlpha(30),
      body: Center(
        child: Padding(
          padding: AppSpacing.screenPaddingAll,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: AppRadius.cardBorderRadius,
            ),
            padding: AppSpacing.cardPaddingAll,
            child: Column(
              mainAxisSize: .min,
              spacing: AppSpacing.m,
              children: [
                Text(
                  context.tr('error.title'),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                AppSpacing.verticalS,
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                AppSpacing.verticalM,
                AppButton(
                  text: context.tr('error.dismiss'),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
