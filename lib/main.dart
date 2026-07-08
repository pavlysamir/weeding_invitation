import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invitation_party/core/theme/app_theme.dart';
import 'package:invitation_party/features/invitation/presentation/cubit/invitation_cubit.dart';
import 'package:invitation_party/features/invitation/presentation/cubit/music_cubit.dart';
import 'package:invitation_party/features/invitation/presentation/pages/invitation_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<InvitationCubit>()..loadWeddingInfo()),
        BlocProvider(create: (_) => di.sl<MusicCubit>()),
      ],
      child: MaterialApp(
        title: 'Elaria & Anton — Wedding Invitation',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const InvitationPage(),
      ),
    );
  }
}
