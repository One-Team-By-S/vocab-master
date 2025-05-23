import 'package:vocab_master/models/quiz_history.dart';
import 'package:vocab_master/models/words_model/group_model.dart';
import 'package:vocab_master/models/words_model/hiveModel.dart';
import 'package:vocab_master/models/words_model/new_model.dart';
import 'package:vocab_master/services/hive_helper/hive_names.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pp;

import '../../models/words_model/word.dart';

class HiveService {
  const HiveService._();
  static Future<void> init() async {
    final dir = await pp.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(HiveVocabluaryModelAdapter());
    Hive.registerAdapter(GroupModelAdapter());
    Hive.registerAdapter(NewModelAdapter());
    Hive.registerAdapter(WordsAdapter());
    Hive.registerAdapter(QuizHistoryAdapter());

    await Hive.openBox<HiveVocabluaryModel>(HiveBoxNames.allvocabluary);
    await Hive.openBox<GroupModel>(HiveBoxNames.renamegroup);
    await Hive.openBox<NewModel>(HiveBoxNames.newfeature);
    await Hive.openBox<dynamic>(HiveBoxNames.filterwords);
    await Hive.openBox<Words>(HiveBoxNames.addwords);
    await Hive.openBox<QuizHistory>(HiveBoxNames.quizhistory);

  }
}
