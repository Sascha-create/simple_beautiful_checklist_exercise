import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  SharedPreferencesAsync prefs = SharedPreferencesAsync();
  List<String> _items = [];

// add Item to List
  @override
  Future<void> addItem(String item) async {
    _items.add(item);
    await prefs.setStringList("items", _items);
  }

  @override
  Future<void> deleteItem(int index) async {
    _items.removeAt(index);
    await prefs.setStringList("items", _items);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    
    if (newItem.isNotEmpty && !_items.contains(newItem)) {
      _items[index] = newItem;
    }
    await prefs.setStringList("items", _items);
  }

// get List with Items
  @override
  Future<List<String>> getItems() async {
    List<String> allItems = await prefs.getStringList("items") ?? [];
    _items.clear();
    _items.addAll(allItems);
    return _items;
  }

  @override
  
  Future<int> get itemCount async {
    List<String> allItems = await prefs.getStringList("items") ?? [];
    return allItems.length;
  }
}
