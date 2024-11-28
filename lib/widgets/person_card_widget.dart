import 'package:flutter/material.dart';
import 'package:op_flutter_challenge/models/people.dart';
import 'package:op_flutter_challenge/providers/people_provider.dart';
import 'package:provider/provider.dart';

class PersonCardWidget extends StatelessWidget {
  final Person person;

  const PersonCardWidget({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PeopleProvider>(context);
    const titleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    final isFav = provider.isFavorite(person);
    IconData icon = isFav ? Icons.favorite : Icons.favorite_border;
    Color color = isFav ? Colors.red : Theme.of(context).colorScheme.primary;

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
                icon: Icon(icon, color: color),
                onPressed: () => provider.addToFavorite(person),
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
