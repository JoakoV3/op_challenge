import 'package:flutter/material.dart';
import 'package:op_flutter_challenge/models/people.dart';
import 'package:op_flutter_challenge/providers/people_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PeopleProvider>(context);
    provider.getPeople(provider.searchController.text);
    return Scaffold(
      body: Column(
        children: [
          _searchBar(),
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
                  return _person(context, person);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: _floatingButton(context),
    );
  }

  Container _floatingButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          const Text("1 de 2", style: TextStyle(color: Colors.black)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward),
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Padding _searchBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: SearchBar(
          leading: Icon(Icons.search),
          hintText: "Buscar personaje de Star Wars",
        ),
      ),
    );
  }

  Container _person(BuildContext context, People person) {
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
          _item("Altura", "${person.height} CM"),
          _item("Peso", "${person.mass} KG"),
          _item("Color de ojos", person.eyeColor),
          _item("Color de cabello", person.hairColor),
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
