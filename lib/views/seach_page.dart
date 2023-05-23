import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/search_suggestions.dart';

class SearchScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestionsAsyncValue = ref.watch(searchSuggestionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
          },
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
        ),
      ),
      body: suggestionsAsyncValue.when(
          data: (suggestions) {
            return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return ListTile(
                  title: Text(suggestion),
                  onTap: () {
                    // Handle suggestion selection
                  },
                );
              },
            );
          },
          loading: () => Center(
                child: CircularProgressIndicator(),
              ),
          error: (error, stackTrace) => Center(
                child: Text('Failed to fetch suggestions'),
              )),
    );
  }
}
