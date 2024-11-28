import 'package:flutter/material.dart';
import 'package:op_flutter_challenge/providers/people_provider.dart';
import 'package:op_flutter_challenge/widgets/bouncing_image_widget.dart';
import 'package:op_flutter_challenge/widgets/people_list_widget.dart';
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
      provider = context.read<PeopleProvider>();
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
            children: [_mainBar(), PeopleListWidget(people: provider.people)],
          ),
          if (provider.people.isEmpty && !provider.loading) _notFound(),
          if (provider.loading) const BouncingImageWidget(),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: _floatingButton(context),
    );
  }

  Padding _mainBar() {
    return Padding(
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
            onPressed: () => Navigator.of(context).pushNamed("/favorites"),
            child: const Text(
              "FAVORITOS",
              style: TextStyle(color: Colors.yellow),
            ),
          )
        ],
      ),
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
}
