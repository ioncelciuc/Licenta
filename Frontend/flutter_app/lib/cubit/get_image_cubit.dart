import 'package:bloc/bloc.dart';
import 'package:flutter_app/network/helper/image_helper.dart';
import 'package:flutter_app/network/response/response.dart';

part 'get_image_state.dart';

class GetImageCubit extends Cubit<GetImageState> {
  late String image;

  GetImageCubit() : super(GetImageInitial());

  getImage(String cardId) async {
    emit(GetImageLoading());

    Response response = await ImageHelper.getImage(cardId);

    if (response.success) {
      emit(GetImageCompleted());
      image = response.obj as String;
      return;
    }

    emit(GetImageFailed(response));
  }
}
