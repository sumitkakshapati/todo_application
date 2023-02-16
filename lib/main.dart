import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/cubit/delete_note_cubit.dart';
import 'package:todo_application/cubit/fetch_notes_cubit.dart';
import 'package:todo_application/cubit/save_note_cubit.dart';
import 'package:todo_application/cubit/update_note_cubit.dart';
import 'package:todo_application/homepage_screen.dart';
import 'package:todo_application/providers/add_note_provider.dart';
import 'package:todo_application/providers/delete_note_provider.dart';
import 'package:todo_application/providers/update_note_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SaveNoteCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateNoteCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteNoteCubit(),
        ),
        BlocProvider(
          create: (context) => FetchNotesCubit(
            saveNoteCubit: BlocProvider.of<SaveNoteCubit>(context),
            updateNoteCubit: BlocProvider.of<UpdateNoteCubit>(context),
            deleteNoteCubit: BlocProvider.of<DeleteNoteCubit>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Todo Application',
        theme: ThemeData(
          primarySwatch: Colors.red,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(),
          ),
        ),
        home: const HomepageScreen(),
      ),
    );
  }
}
