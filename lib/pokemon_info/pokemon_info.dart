import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_evolution.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_stat.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_strength.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_move.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonInfoScreen extends StatefulWidget {
  final Pokemon pokemon;
  PokemonInfoScreen(this.pokemon);
  @override
  _PokemonInfoScreenState createState() => _PokemonInfoScreenState();
}

class _PokemonInfoScreenState extends State<PokemonInfoScreen> {
  final panelController = PanelController();
  final double tabBarHeight = 80;

  Widget buildPokemonTypes(Pokemon pokemon) {
    if (pokemon != null) {
      final typeLength = pokemon.types.length;
      return Row(
          children: List.generate(typeLength, (index) {
        return Container(
          height: 35,
          width: 70,
          child: Card(
            color: Palette().getSelectedTypeColor(
                pokemon.types[index], getAllTypeInString()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(pokemon.types[index],
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      }));
    } else {
      return Text('???');
    }
  }

  Widget buildHeader(Pokemon pokemon) {
    return Column(children: [
      Text(
        pokemon.name,
        style: Theme.of(context).textTheme.headline4,
      ),
      buildPokemonTypes(pokemon)
    ]);
  }

  Widget buildSlidingPanel({
    required PanelController panelController,
    required ScrollController scrollController,
    required Pokemon pokemon,
  }) =>
      DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: buildTabBar(
            onClicked: panelController.open,
          ) as PreferredSizeWidget,
          body: TabBarView(
            children: [
              TabStatWidget(
                scrollController: scrollController,
                pokemon: pokemon,
              ),
              TabSrengthWidget(
                scrollController: scrollController,
                pokemon: pokemon,
              ),
              TabEvolutionWidget(
                scrollController: scrollController,
                pokemon: pokemon,
              ),
              TabMoveWidget(
                scrollController: scrollController,
                pokemon: pokemon,
              ),
            ],
          ),
        ),
      );

  Widget buildTabBar({
    required VoidCallback onClicked,
  }) =>
      PreferredSize(
        preferredSize: Size.fromHeight(tabBarHeight - 8),
        child: GestureDetector(
          onTap: onClicked,
          child: AppBar(
            automaticallyImplyLeading: false,
            title: buildDragIcon(), //Icon(Icons.drag_handle),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(child: Text('Stat')),
                Tab(child: Text('Strength')),
                Tab(child: Text('Move')),
                Tab(child: Text('Evolution')),
              ],
            ),
          ),
        ),
      );

  Widget buildDragIcon() => Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 40,
        height: 8,
      );

  @override
  Widget build(BuildContext context) {
    final panelController = PanelController();
    final double tabBarHeight = 80;

    return Scaffold(
        appBar: AppBar(
          title: Text("pokemon name"),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  buildHeader(widget.pokemon)

                  // Image.asset('assets/images/pokemons/1.png'),
                ],
              ),
            ),
            SlidingUpPanel(
              controller: panelController,
              maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
              panelBuilder: (scrollController) => buildSlidingPanel(
                  scrollController: scrollController,
                  panelController: panelController,
                  pokemon: widget.pokemon),
              body: Image.asset(
                  'assets/images/pokemons/${widget.pokemon.index}.png'),
            )
          ],
        ));
  }
}
