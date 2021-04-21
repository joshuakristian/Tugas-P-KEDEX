import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pokedex2/pokemon.dart';
import 'package:pokedex2/pokemon_info.dart';

class PokeCard extends StatefulWidget {
  const PokeCard({Key key, this.pokeURL}) : super(key: key);
  final String pokeURL;

  @override
  _PokeCardState createState() => _PokeCardState();
}

class _PokeCardState extends State<PokeCard> {
  Pokemon pokemon;

  _fetchData() async {
    final response = await http.get(widget.pokeURL);
    final decode = json.decode(response.body);
    final data = Pokemon.fromJson(decode);

    setState(() {
      pokemon = data;
    });
  }

  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: _setColor(pokemon),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DetailPage(pokemon)));
            },
            child: pokemon == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        pokemon.sprites.frontDefault,
                        width: 130,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        pokemon.name,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  ),
          )),
    );
  }
}

_setColor(Pokemon pokemon) {
  Color defaultColor = Colors.blueGrey;
  Color blue = Color(0xFF18FFFF);
  Color yellowAccent = Color(0xFFFFFF00);
  Color red = Color(0xFFD50000);
  Color green = Color(0xB383FF74);
  Color grey = Colors.white12;
  Color purple = Color(0xFF673AB7);
  Color yellow = Color(0xB3FCBC3A);
  Color earth = Colors.brown;
  Color fairy = Color(0xFFEA80FC);
  Color orange = Color(0xCBEA740A);
  Color brownDark = Color(0xCB44372D);
  Color greyDark = Color(0xFF616161);
  Color dragon = Color(0xFFFF1744);
  Color pokeColor;

  if (pokemon != null) {
    for (int i = 0; i < pokemon.types.length; i++) {
      if (pokemon.types[i].type.name == "water") {
        pokeColor = blue;
      }
      if (pokemon.types[i].type.name == "fire") {
        pokeColor = red;
      }
      if (pokemon.types[i].type.name == "grass") {
        pokeColor = green;
      }
      if (pokemon.types[i].type.name == "bug") {
        pokeColor = yellow;
      }
      if (pokemon.types[i].type.name == "normal") {
        pokeColor = grey;
      }
      if (pokemon.types[i].type.name == "poison") {
        pokeColor = purple;
      }
      if (pokemon.types[i].type.name == "electric") {
        pokeColor = yellowAccent;
      }
      if (pokemon.types[i].type.name == "ground") {
        pokeColor = earth;
      }
      if (pokemon.types[i].type.name == "fairy") {
        pokeColor = fairy;
      }
      if (pokemon.types[i].type.name == "fighting") {
        pokeColor = orange;
      }
      if (pokemon.types[i].type.name == "psychic") {
        pokeColor = brownDark;
      }
      if (pokemon.types[i].type.name == "rock") {
        pokeColor = greyDark;
      }
      if (pokemon.types[i].type.name == "ghost") {
        pokeColor = purple;
      }
      if (pokemon.types[i].type.name == "ice") {
        pokeColor = blue;
      }
      if (pokemon.types[i].type.name == "dragon") {
        pokeColor = dragon;
      }

      return pokeColor;
    }
  }
  return defaultColor;
}
