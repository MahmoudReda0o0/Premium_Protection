import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_checker_state.dart';

class InternetCheckerCubit extends Cubit<InternetCheckerState> {
  InternetCheckerCubit() : super(InternetCheckerState(isConnected: false)) {
    listenInternetConnection();
  }

  listenInternetConnection() {
    InternetConnectionChecker.instance.onStatusChange.listen((status) {
      bool isConnected = status == InternetConnectionStatus.connected;
      print('👌👌👌 Listen Internet Connection: $isConnected');
      emit(InternetCheckerState(isConnected: isConnected));
    });
  }

  checkOnceInternetConnection(bool isConnected) async {
    print('👌👌👌 check Once Internet Connection: $isConnected');
    emit(InternetCheckerState(isConnected: isConnected));
  }
}
