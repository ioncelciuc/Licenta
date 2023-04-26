import 'package:bloc/bloc.dart';
import 'package:flutter_app/network/helper/image_helper.dart';
import 'package:flutter_app/network/response/response.dart';
import 'package:flutter_app/utils/image_type.dart';

part 'get_image_state.dart';

class GetImageCubit extends Cubit<GetImageState> {
  late String image;
  String? banlist;

  GetImageCubit() : super(GetImageInitial());

  getImage(String cardId, String? banlist, ImageType imageType) async {
    emit(GetImageLoading());

    this.banlist = banlist;

    //if you have local images, uncomment this
    // YuGiOhImage yuGiOhImage = HiveHelper.getImage(cardId);
    // if (yuGiOhImage.cardId != null) {
    //   image = yuGiOhImage.imageUrl!;
    //   if (!isClosed) {
    //     emit(GetImageCompleted());
    //   }
    //   return;
    // }
    Response response;
    if (imageType == ImageType.CARD) {
      response = await ImageHelper.getImage(cardId);
    } else if (imageType == ImageType.CARD_SMALL) {
      response = await ImageHelper.getImageSmall(cardId);
    } else {
      response = await ImageHelper.getArtwork(cardId);
    }

    if (response.success) {
      image = response.obj as String;
      if (!isClosed) {
        emit(GetImageCompleted());
      }
      return;
    }

    if (!isClosed) {
      emit(GetImageFailed(response));
    }
  }
}
