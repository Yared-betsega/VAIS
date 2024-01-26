import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vais_mobile/features/transcription/presentation/bloc/transcription/transcription_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vais_mobile/features/transcription/presentation/pages/transcribe.dart';
import 'core/injection/injection_container.dart' as injection;

void main() async {
  runApp(const MyApp());
  await injection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screentype) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: MultiBlocProvider(
            providers: [
              BlocProvider<TranscriptionBloc>(
                  create: (context) => injection.sl<TranscriptionBloc>()),
            ],
            child: const MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const TranscribePage(
      title: "VAIS",
    );
  }
}
