import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedEventsList extends StateNotifier<List<String>> {
  SavedEventsList() : super([]) {
    _loadSavedEvents();
  }
  List<String> savedEventsId = [];

  Future<void> _loadSavedEvents() async {
    final pref = await SharedPreferences.getInstance();
    final savedEvents = pref.getStringList("saved-events");
    state = savedEvents ?? [];
  }

  bool toggleSavedEvents(String id) {
    final mealIsFavorite = state.contains(id);
    if (mealIsFavorite) {
      state = state.where((m) => m != id).toList();
    } else {
      state = [...state, id];
    }
    _saveToPreferences(state);
    return !mealIsFavorite;
  }

  void _saveToPreferences(List<String> savedEvents) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setStringList("saved-events", savedEvents);
  }
}

final savedEventsProvider =
    StateNotifierProvider<SavedEventsList, List<String>>((ref) {
  return SavedEventsList();
});
