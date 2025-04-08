import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab_master/services/hive_helper/hive_names.dart';
import '../../models/words_model/word.dart';
part 'get_word_event.dart';
part 'get_word_state.dart';

class GetWordBloc extends Bloc<GetWordEvent, GetWordState> {
  GetWordBloc() : super(GetWordInitial()) {
    on<GetAllEvent>(getallW);
  }

  Future<void> getallW(
    GetAllEvent event,
    Emitter<GetWordState> emmit,
  ) async {
    emmit(GetProccesState());
    List<Words> all = await HiveBoxes.addwords.values.toList();
    emmit(GetAllState(allW: all));
    
  }
}
