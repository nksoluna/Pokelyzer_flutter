import 'package:flutter/material.dart';

class PokemonSelectorWidget extends StatefulWidget {
  final double width;
  final String imagePath;
  final Function() onTap;
  PokemonSelectorWidget({
    Key? key,
    required this.width,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  _PokemonSelectorWidgetState createState() => _PokemonSelectorWidgetState();
}

class _PokemonSelectorWidgetState extends State<PokemonSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey[800]!,
            offset: Offset(0.0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      width: widget.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ClipOval(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            child: Image.asset(widget.imagePath),
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }
}
