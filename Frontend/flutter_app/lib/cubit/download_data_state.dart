part of 'download_data_cubit.dart';

abstract class DownloadDataState {}

class DownloadDataInitial extends DownloadDataState {}

class DownloadDataLoading extends DownloadDataState {}

class DownloadDataCompleted extends DownloadDataState {}

class DownloadDataFailed extends DownloadDataState {
  Response response;

  DownloadDataFailed(this.response);
}
