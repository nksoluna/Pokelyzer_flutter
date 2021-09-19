import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/Helpers/string_extension.dart';
import 'package:pokelyzer/models/type.dart';

class PokemonSelectorWidget extends StatefulWidget {
  final double width;
  final Pokemon? selectedPokemon;
  final Function() onTap;
  PokemonSelectorWidget({
    Key? key,
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
        buildPokemonName(widget.selectedPokemon),
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
                child: Image.asset(getImagePath(widget.selectedPokemon)),
                onTap: widget.onTap,
              ),
            ),
          ),
        ),
        buildPokemonType(widget.selectedPokemon),
      ],
    );
  }

  String getImagePath(Pokemon? pokemon) {
    if (pokemon != null) {
      return 'assets/images/pokemons/' + pokemon.index.toString() + ".png";
    }
    return 'assets/images/pokemons/201.png';
  }

  Widget buildPokemonName(Pokemon? pokemon) {
    final pokemonName = widget.selectedPokemon?.name.capitalize() ?? '-';
    return Text(pokemonName, style: Theme.of(context).textTheme.headline4);
  }

  Widget buildPokemonType(Pokemon? pokemon) {
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

    if (pokemon != null) {
      final typeLength = pokemon.types.length;
      return Row(
          children: List.generate(typeLength, (index) {
        return buildCard(text: pokemon.types[index]);
      }));
    }
    return buildCard(text: '???', color: Colors.black);
  }
}
