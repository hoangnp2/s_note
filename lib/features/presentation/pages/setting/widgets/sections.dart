import 'package:flutter/material.dart';
import 'package:s_note/features/presentation/pages/setting/widgets/tiles_section.dart';

class Sections extends StatelessWidget {
  const Sections({super.key, required this.sections});

  final List<TilesSection> sections;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...sections],
    );
  }
}
