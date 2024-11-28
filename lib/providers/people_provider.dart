import 'package:flutter/material.dart';
import 'package:op_flutter_challenge/models/people.dart';
import 'package:op_flutter_challenge/services/people_service.dart';

class PeopleProvider extends ChangeNotifier {
  final _service = PeopleService();
  TextEditingController searchController = TextEditingController();

  List<People> people = [];
  int currentPage = 1;

  Future<void> getPeople(String search) async {
    if (people.isNotEmpty) return;
    final response = await _service.getPeople(1, search);
    people = response.results;
    notifyListeners();
  }

  Future<void> nextPage(String search) async {
    final response = await _service.getPeople(currentPage++, search);
    people.addAll(response.results);
    notifyListeners();
  }
}
