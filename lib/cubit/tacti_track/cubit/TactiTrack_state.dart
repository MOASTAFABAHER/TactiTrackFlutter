part of 'TactiTrack_cubit.dart';

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

class PickDataErrorState extends TactiTrackState {}

class PickDataSucssessState extends TactiTrackState {}

class ChangeIsZoneState extends TactiTrackState {}

class ChangeIsPassState extends TactiTrackState {}
