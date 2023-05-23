import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

final searchQueryProvider = StateProvider<String>((ref) => '');
