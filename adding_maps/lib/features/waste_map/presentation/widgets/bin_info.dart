import 'package:flutter/material.dart';
import 'package:adding_maps/features/waste_map/domain/entities/bin_entity.dart';

class BinInfoCard extends StatelessWidget {
  final Bin bin;

  const BinInfoCard({super.key, required this.bin});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 20,
      right: 60,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bin.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text("Next Collection: ${bin.nextCollection}"),
            const SizedBox(height: 5),
            Text(bin.isPublic ? "Public Bin" : "Private Bin"),
          ],
        ),
      ),
    );
  }
}
