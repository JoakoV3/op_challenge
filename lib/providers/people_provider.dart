import 'package:flutter/material.dart';
import 'package:op_flutter_challenge/models/people.dart';
import 'package:op_flutter_challenge/services/people_service.dart';

class PeopleProvider extends ChangeNotifier {
  final _service = PeopleService();
  TextEditingController searchController = TextEditingController();

  List<People> people = [];
  int totalPages = 0;
  int currentPage = 1;
  bool loading = true;

  Future<void> getPeople(String search) async {
    changeLoading(true);
    final response = await _service.getPeople(1, search);
    people = response.results;
    currentPage = 1;
    totalPages = response.count > 10 ? (response.count / 10).truncate() : 1;
    changeLoading(false);
  }

  Future<void> changePage(String search, {bool goBack = false}) async {
    if (currentPage >= totalPages || (goBack && currentPage == 1)) return;
    changeLoading(true);
    currentPage = goBack ? currentPage - 1 : currentPage + 1;
    final response = await _service.getPeople(currentPage, search);
    people.clear();
    people = response.results;
    changeLoading(false);
  }

  void changeLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
