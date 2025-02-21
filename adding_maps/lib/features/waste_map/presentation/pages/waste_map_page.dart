import 'package:adding_maps/features/waste_map/presentation/pages/waste_map_perview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adding_maps/features/waste_map/presentation/bloc/waste_bloc.dart';
import 'package:adding_maps/features/waste_map/presentation/bloc/waste_event.dart';
import 'package:adding_maps/features/waste_map/presentation/bloc/waste_state.dart';
import 'package:adding_maps/injection_container.dart';

class WasteMapScreen extends StatelessWidget {
  const WasteMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WasteMapBloc>()..add(LoadWasteMap()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Waste Category Map")),
        body: BlocBuilder<WasteMapBloc, WasteMapState>(
          builder: (context, state) {
            if (state is WasteMapLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WasteMapLoaded) {
              return WasteMapPreview(state: state);
            } else if (state is WasteMapError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
