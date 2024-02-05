import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:waythru/cubits/auth.dart';
import 'package:waythru/services/services.dart';

import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ConvoApp());
}

class ConvoApp extends StatelessWidget {
  const ConvoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService service;
    Style().lightOverlay(context);
    return ScreenUtilInit(builder: (context, child) {
      return MultiBlocProvider(
          providers: [BlocProvider(create: (_) => AuthCubit())],
          child: const App());
    });
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Convo',
        debugShowCheckedModeBanner: false,
        theme: Style.light,
        themeMode: ThemeMode.light,
        initialRoute: context.read<AuthCubit>().isLogin? Pages.home: Pages.initial,
        onGenerateRoute: Routes.onGenerateRoute);
  }
}
