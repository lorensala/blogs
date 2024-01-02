import 'package:bloc_rxdart_example/bloc/bloc.dart';
import 'package:bloc_rxdart_example/repository/repository.dart';
import 'package:bloc_rxdart_example/service/service.dart';
import 'package:bloc_rxdart_example/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PowerService>(
          create: (context) => PowerServiceImpl(),
        ),
        RepositoryProvider<PowerRepository>(
          create: (context) => PowerRepositoryImpl(
            service: context.read<PowerService>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PowerDataBloc(
              repository: context.read<PowerRepository>(),
            )..add(const PowerDataStarted()),
          ),
          BlocProvider(
            create: (context) => PowerSwitchBloc(
              repository: context.read<PowerRepository>(),
            )..add(const PowerSwitchStarted()),
          ),
          BlocProvider(
            create: (context) => PowerNotifierBloc(
              repository: context.read<PowerRepository>(),
            )..add(const PowerNotifierStarted()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const PowerView(),
        ),
      ),
    );
  }
}
