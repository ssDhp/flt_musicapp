import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/auth/view_models/auth_viewmodel.dart';
import 'package:client/features/home/views/pages/home_page.dart';
import 'package:client/features/home/views/pages/upload_song_page.dart';
import 'package:flutter/material.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/views/pages/signup_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  final providerContainer = ProviderContainer();
  await providerContainer
      .read(authViewModelProvider.notifier)
      .initSharedPrefrences();

  final userModel =
      await providerContainer.read(authViewModelProvider.notifier).getData();
  print('Current User: $userModel');

  runApp(
    UncontrolledProviderScope(
      container: providerContainer,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      title: 'Flutter Music App',
      theme: AppTheme.dartTheme,
      debugShowCheckedModeBanner: false,
      home: currentUser == null ? const SignupPage() : const HomePage(),
    );
  }
}
