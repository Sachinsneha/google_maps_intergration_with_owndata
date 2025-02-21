import 'package:adding_maps/features/waste_map/presentation/bloc/waste_bloc.dart';
import 'package:adding_maps/features/waste_map/presentation/bloc/waste_event.dart';
import 'package:adding_maps/features/waste_map/presentation/pages/waste_map_page.dart';
import 'package:adding_maps/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WasteMapBloc>()..add(LoadWasteMap()),
      child: MaterialApp(
        title: "Waste Map",
        theme: ThemeData(primarySwatch: Colors.green),
        home: const WasteMapScreen(),
      ),
    );
  }
}
