import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:yu_gi_oh_app/infrastructure/models/yu-gi-oh/archetypes.dart';

class SearchArchetypeDelegate extends SearchDelegate<Archetype?> {
  List<Archetype> initialArchetypes;
  List<Archetype> searchedArchetypes = [];
  final TextStyle searchTextStyle;

  StreamController<List<Archetype>> debouncedArchetypes =
      StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchArchetypeDelegate({
    required this.initialArchetypes,
    required this.searchTextStyle,
  }) : super(
          searchFieldLabel: 'Buscar arquetipo',
          searchFieldStyle: searchTextStyle,
          textInputAction: TextInputAction.send,
        );

  void clearStreams() {
    debouncedArchetypes.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // if (query.trim().isEmpty) {
      //   debouncedArchetypes.add([]);
      //   return;
      // }
      searchedArchetypes = initialArchetypes;

      final archetypes = searchedArchetypes.where((element) {
        return element.archetypeName!
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
      searchedArchetypes = archetypes;
      debouncedArchetypes.add(searchedArchetypes);
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: searchedArchetypes,
      stream: debouncedArchetypes.stream,
      builder: (context, snapshot) {
        final archetypes = snapshot.data ?? [];

        return ListView.builder(
          itemCount: archetypes.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(archetypes[index].archetypeName!),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              clearStreams();
              close(context, archetypes[index]);
            },
          ),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}
