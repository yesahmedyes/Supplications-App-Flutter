import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplications_app/data/repos/supplicationsRepo.dart';
import 'package:supplications_app/logic/audio/audio_bloc.dart';
import 'package:supplications_app/logic/categories/categories_bloc.dart';
import 'package:supplications_app/logic/supplications/supplications_bloc.dart';
import 'package:supplications_app/presentation/screens/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SupplicationsRepo>(create: (context) => SupplicationsRepo(), lazy: false),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CategoriesBloc>(
            create: (context) => CategoriesBloc(supplicationsRepo: context.read<SupplicationsRepo>())..add(CategoriesFetchEvent()),
            lazy: false,
          ),
          BlocProvider<SupplicationsBloc>(create: (context) => SupplicationsBloc(supplicationsRepo: context.read<SupplicationsRepo>())),
          BlocProvider<AudioBloc>(create: (context) => AudioBloc()),
        ],
        child: MaterialApp(
          title: 'Supplications',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
