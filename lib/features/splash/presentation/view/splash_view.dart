import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/features/splash/presentation/viewmodel/splash_view_model.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashState();
}

class _SplashState extends ConsumerState<SplashView> {
  // late final UserSharedPrefs userSharedPrefs;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
    ref.read(splashViewModelProvider.notifier).init(context);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
