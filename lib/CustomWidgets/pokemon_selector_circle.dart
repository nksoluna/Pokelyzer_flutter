import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/Helpers/string_extension.dart';
import 'package:pokelyzer/models/type_pokemon.dart';

class PokemonSelectorWidget extends StatefulWidget {
  final double width;
  final Pokemon? selectedPokemon;
  final Function() onTap;
  final Color textColor;
  PokemonSelectorWidget({
    Key? key,
    this.textColor = Colors.black,
    this.selectedPokemon,
    required this.width,
    required this.onTap,
  }) : super(key: key);

  @override
  _PokemonSelectorWidgetState createState() => _PokemonSelectorWidgetState();
}

class _PokemonSelectorWidgetState extends State<PokemonSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildPokemonName(),
        Container(
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
                child: Image.asset(getImagePath()),
                onTap: widget.onTap,
              ),
            ),
          ),
        ),
        buildPokemonType(),
      ],
    );
  }

  String getImagePath() {
    if (widget.selectedPokemon != null) {
      return 'assets/images/pokemons/' +
          widget.selectedPokemon!.index.toString() +
          ".png";
    }
    return 'assets/images/pokemons/201.png';
  }

  Widget buildPokemonName() {
    final pokemonName = widget.selectedPokemon?.name.capitalize() ?? '-';
    return Text(pokemonName,
        style: Theme.of(context)
            .textTheme
            .headline4!
            .merge(TextStyle(color: widget.textColor)));
  }

  Widget buildPokemonType() {
    Widget buildCard({required String text, Color? color}) {
      var cardColor = color;
      if (color == null) {
        cardColor = Palette().getSelectedTypeColor(text, getAllTypeInString());
      }
      return Container(
        height: 35,
        width: 70,
        child: Card(
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(text, style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    }

    if (widget.selectedPokemon != null) {
      final typeLength = widget.selectedPokemon!.types.length;
      return Row(
          children: List.generate(
              typeLength,
              (index) =>
                  buildCard(text: widget.selectedPokemon!.types[index])));
    }
    return buildCard(text: '???', color: Colors.black);
  }
}
