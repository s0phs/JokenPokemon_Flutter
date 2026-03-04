import 'package:flutter/material.dart';

void main(){
  runApp(JokenPokemonApp());
}

class JokenPokemonApp extends StatelessWidget {
  const JokenPokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JokenPokemon',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class Pokemon {
  final String name;
  final String imagePath;

  Pokemon({required this.name, required this.imagePath});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Pokemon> pokemons = [
    Pokemon(name: "Bulbassaur", imagePath: "images/bulbassaur.png"),
    Pokemon(name: "Charmander", imagePath: "images/charmander.png"),
    Pokemon(name: "Squirtle", imagePath: "images/squirtle.png"),
  ];

  Pokemon? playerChoice = null;
  Pokemon? computerChoice = null;
  String result = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0),child: PokemonLogo()),
          BattleArena(result: "Teste"),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Faça sua jogada de mestre"),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemons.map((p) {
                  return PokemonOption(
                    selected: playerChoice == p,
                    pokemon: p,
                    onSelected: (pokemon) {},  
                  );
                }).toList(),
              )
            ],
          )
        ],
      ),
    );
  }
}

class PokemonLogo extends StatelessWidget {
  const PokemonLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset("images/logo_pokemon.png", height: 120);
  }
}

class BattleArena extends StatelessWidget {
  final Pokemon? player;
  final Pokemon? computer;
  final String result;

  const BattleArena({
    super.key, 
    this.player, 
    this.computer, 
    required this.result
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            PokemonCard(pokemon: player, playerName: "Você"),
            PokemonCard(pokemon: computer, playerName: "Computador"),
          ],
        ),

        BattleResult(result: result),
      ],
    );
  }
}

class PokemonCard extends StatelessWidget {
  final Pokemon? pokemon;
  final String playerName;

  const PokemonCard({super.key, this.pokemon, required this.playerName});//pokemon não é required pq pode ser nulo
  

  @override
  Widget build(BuildContext context) {
    if(pokemon == null){
      return PokemonCardItemDefault(playerName);
    }else{
      return PokemonCardItem(pokemon: pokemon!, playerName: playerName);//"!" para avisar q o caso do pokemon ser nulo ja foi tratado
    }
    
  }
}

class PokemonCardItemDefault extends StatelessWidget {
  final String playerName;
  
  const PokemonCardItemDefault(this.playerName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("images/pokeball_unselected.png", height: 120),
        SizedBox(height: 8),
        Text("-"),
        SizedBox(height: 8),
        Text(playerName)
      ],
    );
  }
}

class BattleResult extends StatelessWidget {
  final String result;

  const BattleResult({super.key, required this.result});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(result, style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.redAccent
      ),),
    );
  }
}

class PokemonCardItem extends StatelessWidget {
  final Pokemon pokemon;
  final String playerName;

  const PokemonCardItem({super.key, required this.pokemon, required this.playerName});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pokemon.imagePath, height: 250),
        SizedBox(height: 8),
        Text(pokemon.name),
        SizedBox(height: 8),
        Text(playerName)
      ],
    );
  }
}

class PokemonOption extends StatelessWidget {
  final bool selected;
  final Pokemon pokemon;
  final Function(Pokemon) onSelected;

  const PokemonOption({super.key, required this.selected, required this.pokemon, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(pokemon),
      child: Column(
        children: [
          Image.asset(selected? "images/pokeball_selected.png":"images/pokeball_unselected.png",
          height: 40,
          width: 40
          ),
          SizedBox(height: 4),
          Text(pokemon.name, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}


