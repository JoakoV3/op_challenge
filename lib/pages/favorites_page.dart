import 'package:flutter/material.dart';
import 'package:op_flutter_challenge/providers/people_provider.dart';
import 'package:op_flutter_challenge/widgets/people_list_widget.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<PeopleProvider>();
      provider.initFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontSize: 20,
    );
    return Scaffold(
      body: Consumer<PeopleProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 20),
                    Text("PERSONAJES FAVORITOS", style: textStyle),
                    const SizedBox(width: 20),
                    _searchBar(provider),
                  ],
                ),
              ),
              if (provider.filteredFavorite.isEmpty &&
                  provider.favoritePeople.isNotEmpty)
                _emptyList(
                  "No tenes en favoritos personajes que coincidan con: \"${provider.favoriteSearchController.text}\"",
                ),
              if (provider.favoritePeople.isEmpty)
                _emptyList("No se encontraron personajes favoritos"),
              PeopleListWidget(people: provider.filteredFavorite),
            ],
          );
        },
      ),
    );
  }

  SizedBox _emptyList(String text) {
    const textStyle = TextStyle(
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Text(text, style: textStyle, textAlign: TextAlign.center),
      ),
    );
  }

  Flexible _searchBar(PeopleProvider provider) {
    return Flexible(
      child: SearchBar(
        controller: provider.favoriteSearchController,
        leading: const Icon(Icons.search),
        hintText: "Buscar personaje de Star Wars",
        onChanged: (value) {
          provider.searchFavorite(value);
        },
        trailing: [
          IconButton(
            onPressed: () => provider.clearFavoriteSearch(),
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
    );
  }
}
