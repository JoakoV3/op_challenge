import 'package:flutter/material.dart';
import 'package:op_flutter_challenge/models/people.dart';
import 'package:op_flutter_challenge/services/people_service.dart';

class PeopleProvider extends ChangeNotifier {
  final _service = PeopleService();
  TextEditingController searchController = TextEditingController();
  TextEditingController favoriteSearchController = TextEditingController();

  List<Person> people = [];
  List<Person> favoritePeople = [];
  List<Person> filteredFavorite = [];

  int totalPages = 0;
  int currentPage = 1;
  bool loading = true;

  bool isFavorite(Person people) =>
      favoritePeople.any((p) => p.url == people.url);

  Future<void> getPeople(String search) async {
    changeLoading(true);
    final response = await _service.getPeople(1, search);
    people = response.results;
    currentPage = 1;
    totalPages = response.count > 10 ? (response.count / 10).truncate() : 1;
    changeLoading(false);
  }

  Future<void> changePage(String search, {bool goBack = false}) async {
    if ((!goBack && currentPage >= totalPages) ||
        (goBack && currentPage == 1)) {
      return;
    }
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

  void initFavorite() {
    filteredFavorite = favoritePeople;
    notifyListeners();
  }

  void addToFavorite(Person people) {
    isFavorite(people)
        ? favoritePeople.removeWhere((element) => element.url == people.url)
        : favoritePeople.add(people);
    notifyListeners();
  }

  void searchFavorite(String value) {
    if (value.isEmpty) {
      filteredFavorite = favoritePeople;
      notifyListeners();
      return;
    }

    filteredFavorite = favoritePeople
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void clearFavoriteSearch() {
    favoriteSearchController.clear();
    filteredFavorite = favoritePeople;
    notifyListeners();
  }
}
