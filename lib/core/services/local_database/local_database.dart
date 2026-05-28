import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const String _counterKey = 'counter';
  static const String _tasksListKey = 'tasksList';

  static Future<void> saveCounter({required int value}) async {
    await _preferences?.setInt(_counterKey, value);
  }

  static int getCounter() {
    return _preferences?.getInt(_counterKey) ?? 0;
  }

  static Future<void> saveTasksList({required List<String> tasks}) async {
    await _preferences?.setStringList(_tasksListKey, tasks);
  }

  static List<String> getTasksList() {
    return _preferences?.getStringList(_tasksListKey) ?? [];
  }

  static Future<void> addTask(String task) async {
    List<String> tasks = getTasksList();
    tasks.add(task);

    await saveTasksList(tasks: tasks);
  }

  static Future<void> deleteTask(int index) async {
    List<String> tasks = getTasksList();
    tasks.removeAt(index);

    await saveTasksList(tasks: tasks);
  }
}
