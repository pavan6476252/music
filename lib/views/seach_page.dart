import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';

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
          onSubmitted: (value) {
            ref.refresh(searchSuggestionsProvider.future);
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
        ),
      ),
    );
  }
}

final searchSuggestionsProvider =
    FutureProvider.autoDispose<List<String>>((ref) async {
  final query = ref.watch(searchQueryProvider.notifier).state;
  final url = 'https://python-music-server.vercel.app/suggestions?query=$query';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final suggestions = List<String>.from(jsonData);
      return suggestions;
    } else {
      throw Exception('Failed to fetch suggestions: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
});

final searchQueryProvider = StateProvider<String>((ref) => 'Telugu');
