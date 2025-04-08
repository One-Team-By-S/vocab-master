import 'package:vocab_master/models/quiz_history.dart';
import 'package:vocab_master/models/words_model/hiveModel.dart';
import 'package:vocab_master/models/words_model/new_model.dart';
import 'package:hive/hive.dart';

import '../../models/words_model/word.dart';

class HiveBoxes {
  const HiveBoxes._();

  static final Box<HiveVocabluaryModel> allvocabluary =
      Hive.box(HiveBoxNames.allvocabluary);
  static final Box<NewModel> newWords = Hive.box(HiveBoxNames.newfeature);
  static final Box<dynamic> filterwords = Hive.box(HiveBoxNames.filterwords);
  static final Box<Words> addwords = Hive.box(HiveBoxNames.addwords);
  static final Box<QuizHistory> quizhistory = Hive.box(HiveBoxNames.quizhistory);


  static Future<void> clearAllBoxes() async {
    await Future.wait([]);
    allvocabluary.clear();
    filterwords.clear();
  }
}

class HiveBoxNames {
  static const String allvocabluary = 'allvocabluary';
  static const String staticNumber = 'staticNumber';
  static const String renamegroup = 'renamegroup';
  static const String newfeature = 'newfeature';
  static const String filterwords = 'filterwords';
  static const String addwords = 'addwords';
  static const String quizhistory = 'quizhistory';

}
