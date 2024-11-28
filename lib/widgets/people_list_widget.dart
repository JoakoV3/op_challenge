import 'package:flutter/material.dart';
import 'package:op_flutter_challenge/models/people.dart';
import 'package:op_flutter_challenge/widgets/person_card_widget.dart';

class PeopleListWidget extends StatelessWidget {
  const PeopleListWidget({super.key, required this.people});
  final List<Person> people;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 60),
        child: GridView.builder(
          itemCount: people.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (MediaQuery.of(context).size.width ~/ 250).toInt(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.3,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final person = people[index];
            return PersonCardWidget(key: Key(person.url), person: person);
          },
        ),
      ),
    );
  }
}
