part of 'get_image_cubit.dart';

abstract class GetImageState {}

class GetImageInitial extends GetImageState {}

class GetImageLoading extends GetImageState {}

class GetImageCompleted extends GetImageState {}

class GetImageFailed extends GetImageState {
  Response response;

  GetImageFailed(this.response);
}
