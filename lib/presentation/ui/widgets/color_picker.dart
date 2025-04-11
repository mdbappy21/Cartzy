import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.colorNames,
    required this.onColorSelected,
    this.initialColor,
  });

  final List<String> colorNames;
  final Function(Color) onColorSelected;
  final Color? initialColor;

  final Map<String, Color> colorNameMap = const {
    'red': Colors.red,
    'green': Colors.green,
    'white': Colors.white,
    'blue': Colors.blue,
    'yellow': Colors.yellow,
    'black': Colors.black,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'brown': Colors.brown,
    'grey': Colors.grey,
    'gray': Colors.grey,
  };
  Color? getColorFromName(String name) {
    return colorNameMap[name.toLowerCase()];
  }

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late List<Color> _colors;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _colors = widget.colorNames.map((name) => widget.getColorFromName(name)).whereType<Color>().toList();
    _selectedColor = widget.initialColor ?? (_colors.isNotEmpty ? _colors.first : Colors.transparent);

    if (_colors.isNotEmpty) {
      widget.onColorSelected(_selectedColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_colors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _colors.map((color) {
            return GestureDetector(
              onTap: () {
                setState(() => _selectedColor = color);
                widget.onColorSelected(color);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color == Colors.white ? Colors.grey : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 16,
                  child: _selectedColor == color
                      ? Icon(
                    Icons.check,
                    size: 20,
                    color: color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                  )
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}