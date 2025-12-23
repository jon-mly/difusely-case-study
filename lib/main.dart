import 'package:easy_localization/easy_localization.dart';
import 'package:employees_app/presentation/navigation/router.dart';
import 'package:employees_app/presentation/providers/ui/scaffold_messenger_provider.dart';
import 'package:employees_app/presentation/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations([.portraitUp]);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: router,
      title: "Employees App",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      scaffoldMessengerKey: ref.read(scaffoldMessengerKeyProvider),
      locale: context.locale,
      theme: AppTheme.clearTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
