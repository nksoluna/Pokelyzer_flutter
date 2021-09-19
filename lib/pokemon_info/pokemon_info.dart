import 'package:flutter/material.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_evolution.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_stat.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_strength.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_move.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonInfoScreen extends StatefulWidget {
  PokemonInfoScreen({Key? key}) : super(key: key);

  @override
  _PokemonInfoScreenState createState() => _PokemonInfoScreenState();
}

class _PokemonInfoScreenState extends State<PokemonInfoScreen> {
  final PokemonsRepo _repo;
  late Pokemon _pokemon;
  final int _index = 0;

  final panelController = PanelController();
  final double tabBarHeight = 80;

  _PokemonInfoScreenState() : _repo = new PokemonsRepo();

  Future<Pokemon> getPokemon() async {
    var pokemon = await _repo.getPokemonByIndex(_index);
    return pokemon;
  }

  Widget getPokemonTypes(Pokemon pokemon) {
    List<Widget> items = [];
    for (var type in pokemon.types) {
      if (type == 'grass') {
        items.add(Text(
          type,
          style: TextStyle(backgroundColor: Colors.green[600]),
        ));
      } else
        items.add(Text(
          type,
          style: TextStyle(backgroundColor: Colors.purple[800]),
        ));
    }
    return Row(
      children: items,
    );
  }

  Widget buildHeader(Pokemon pokemon) {
    return Column(children: [
      Text(
        pokemon.name,
        style: Theme.of(context).textTheme.headline4,
      ),
      getPokemonTypes(pokemon)
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
        body: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              FutureBuilder(
                  future: getPokemon(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return buildHeader(snapshot.data as Pokemon);
                    }
                    return CircularProgressIndicator();
                  }),
              // Image.asset('assets/images/pokemons/1.png'),
            ],
          ),
        ),
        FutureBuilder(
            future: getPokemon(),
            builder: (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SlidingUpPanel(
                  controller: panelController,
                  maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
                  panelBuilder: (scrollController) => buildSlidingPanel(
                      scrollController: scrollController,
                      panelController: panelController,
                      pokemon: snapshot.data as Pokemon),
                  body: Image.asset('assets/images/pokemons/1.png'),
                );
              }
              return CircularProgressIndicator();
            }),
      ],
    ));
  }
}


        // SlidingUpPanel(
        //   controller: panelController,
        //   maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
        //   panelBuilder: (scrollController) => buildSlidingPanel(
        //     scrollController: scrollController,
        //     panelController: panelController,
        //   ),
        //   body: Image.asset('assets/images/pokemons/1.png'),
        // )