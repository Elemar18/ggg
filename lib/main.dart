import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../firebase_options.dart';
import '../core/router/app_router.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_colors.dart';
/// Initializes Firebase and launches MotoSyncApp.
Future<void> main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColors.background,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light)); runApp(const ProviderScope(child:MotoSyncApp())); }
class MotoSyncApp extends ConsumerWidget { const MotoSyncApp({super.key}); @override Widget build(BuildContext context,WidgetRef ref)=>MaterialApp.router(title:'MotoSyncApp',debugShowCheckedModeBanner:false,theme:AppTheme.light,routerConfig:ref.watch(appRouterProvider)); }
