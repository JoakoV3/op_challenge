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
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .8,
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: people
                    .map((person) => SizedBox(
                          width: 300,
                          height: 290,
                          child: PersonCardWidget(
                            key: Key(person.url),
                            person: person,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
