import 'package:flutter/material.dart';
import 'package:op_flutter_challenge/models/people.dart';
import 'package:op_flutter_challenge/providers/people_provider.dart';
import 'package:op_flutter_challenge/widgets/bouncing_image.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PeopleProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<PeopleProvider>(context, listen: false);
      provider.getPeople(provider.searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<PeopleProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Image(
                      image: AssetImage('assets/star-wars.png'),
                      width: 100,
                    ),
                    const SizedBox(width: 20),
                    _searchBar(provider),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "FAVORITOS",
                        style: TextStyle(color: Colors.yellow),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(bottom: 60),
                  child: GridView.builder(
                    itemCount: provider.people.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          (MediaQuery.of(context).size.width ~/ 250).toInt(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.3,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final person = provider.people[index];
                      return _personCard(context, person);
                    },
                  ),
                ),
              ),
            ],
          ),
          if (provider.people.isEmpty && !provider.loading) _notFound(),
          if (provider.loading) const BouncingImage(),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: _floatingButton(context),
    );
  }

  Center _notFound() {
    const textStyle = TextStyle(
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    return Center(
      child: Text(
        "No se encontraron personajes que coincidan con: \"${provider.searchController.text}\"",
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _floatingButton(BuildContext context) {
    final currentPage = provider.currentPage;
    final count = provider.totalPages;
    final isFirstPage = currentPage == 1;
    final search = provider.searchController.text;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            disabledColor: Colors.black38,
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: isFirstPage
                ? null
                : () => provider.changePage(search, goBack: true),
          ),
          Text(
            "$currentPage de $count",
            style: const TextStyle(color: Colors.black),
          ),
          IconButton(
            onPressed: () => provider.changePage(search),
            icon: const Icon(Icons.arrow_forward),
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Flexible _searchBar(PeopleProvider provider) {
    return Flexible(
      child: Center(
        child: SearchBar(
          controller: provider.searchController,
          leading: const Icon(Icons.search),
          hintText: "Buscar personaje de Star Wars",
          trailing: [
            IconButton(
              onPressed: () {
                provider.searchController.clear();
                provider.getPeople("");
              },
              icon: const Icon(Icons.clear),
            ),
          ],
          onSubmitted: (value) => provider.getPeople(value),
        ),
      ),
    );
  }

  Container _personCard(BuildContext context, People person) {
    const titleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      width: 20,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(person.name, style: titleStyle),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color.fromARGB(255, 172, 172, 172),
          ),
          _item("Altura:", "${person.height} CM"),
          _item("Peso:", "${person.mass} KG"),
          _item("Color de ojos:", person.eyeColor),
          _item("Color de cabello:", person.hairColor),
        ],
      ),
    );
  }

  _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(title,
                style: const TextStyle(fontSize: 15, color: Colors.grey)),
          ),
          Text(value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
