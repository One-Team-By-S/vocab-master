import 'package:hive/hive.dart';

import '../../services/hive_helper/adapter.dart';

part 'word.g.dart';

@HiveType(typeId: 0,adapterName: HiveAdapters.wordsadapter)
class Words extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? nameEn;

  @HiveField(2)
  String? nameUz;

  @HiveField(3)
  bool? isSelected;

  Words({
    this.id,
    this.nameEn,
    this.nameUz,
    this.isSelected,
  });
}
