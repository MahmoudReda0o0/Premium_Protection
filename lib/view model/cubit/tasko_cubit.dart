import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'tasko_state.dart';

class TaskoCubit extends Cubit<TaskoState> {
  TaskoCubit() : super(TaskoInitial());
}
