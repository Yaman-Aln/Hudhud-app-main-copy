// lib/z_onboarding/services/user_preferences_manager.dart

import 'package:hive/hive.dart';
import '../models/unique_test_model.dart';

class UserPreferencesManager {
  static final UserPreferencesManager instance = UserPreferencesManager._internal();
  UserPreferencesManager._internal();

  /// IMPORTANT: Make sure this box name ('userProfileBox') exactly matches
  /// what you open in main.dart (e.g. `await Hive.openBox<UniqueTestModel>('userProfileBox');`).
  static const String _userBoxName = 'userProfileBox';

  // A convenience key for storing the single UniqueTestModel instance.
  static const String _modelKey = 'uniqueTestModel';

  /// Load the model from the Hive box, or create a default if none is found.
  Future<UniqueTestModel> loadUniqueTestModel() async {
    final box = await Hive.openBox<UniqueTestModel>(_userBoxName);

    // Retrieve the model by the known key.
    final storedModel = box.get(_modelKey);

    // If not found, create + store a default model.
    if (storedModel == null) {
      final defaultModel = UniqueTestModel();
      await box.put(_modelKey, defaultModel);
      return defaultModel;
    } else {
      return storedModel;
    }
  }

  /// Save (or overwrite) the entire [UniqueTestModel] to Hive under the same key.
  Future<void> saveUniqueTestModel(UniqueTestModel model) async {
    final box = await Hive.openBox<UniqueTestModel>(_userBoxName);
    await box.put(_modelKey, model);
  }

  // --- Optional convenience methods for reading/writing just the name field ---

  /// Get only the user's name from the existing [UniqueTestModel].
  Future<String> getName() async {
    final model = await loadUniqueTestModel();
    return model.name;
  }

  /// Update just the user's name field in the model and persist it.
  Future<void> setName(String newName) async {
    final model = await loadUniqueTestModel();
    model.name = newName;
    await saveUniqueTestModel(model);
  }
}
