import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BottomnavbarCubit extends Cubit<int> {
  BottomnavbarCubit() : super(0);

  onpagechange(int index) {
    emit(index);
  
  }
  @override
  Future<void> close() {
   BottomnavbarCubit().close();
    return super.close();
  }


  
}
