part of 'user_available_time_bloc.dart';

abstract class UserAvailableTimeEvent {}

class FetchDayWorkShift extends UserAvailableTimeEvent {
  FetchDayWorkShift(this.date);
  final DateTime date;
}

class PostWorkShift extends UserAvailableTimeEvent {
  PostWorkShift(this.workShift);
  final WorkShift workShift;
}

class DeleteWorkShift extends UserAvailableTimeEvent {
  DeleteWorkShift(this.workShift);
  final WorkShift workShift;
}
