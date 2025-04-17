part of 'TactiTrack_cibit.dart';

abstract class TactiTrackState {}

class TactiTrackInitial extends TactiTrackState {}

class TactiTrackUploadVideoLoadingState extends TactiTrackState {}

class TactiTrackUploadVideoSuccessState extends TactiTrackState {}

class TactiTrackUploadVideoErrorState extends TactiTrackState {}

class DownloadingVideoLoadingState extends TactiTrackState {}

class DownloadingVideoSuccessState extends TactiTrackState {}

class DownloadingVideoErrorState extends TactiTrackState {}

class TactiTrackUploadImageLoadingState extends TactiTrackState {}

class TactiTrackUploadImageSuccessState extends TactiTrackState {}

class TactiTrackUploadImageErrorState extends TactiTrackState {}
