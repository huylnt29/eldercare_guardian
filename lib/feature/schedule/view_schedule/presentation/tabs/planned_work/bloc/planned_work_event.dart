part of 'planned_work_bloc.dart';

abstract class PlannedWorkEvent {}

class InitScreenEvent extends PlannedWorkEvent {
  InitScreenEvent();
}

class GetAipsEvent extends PlannedWorkEvent {
  GetAipsEvent();
}

class ChangeDateTimeEvent extends PlannedWorkEvent {
  ChangeDateTimeEvent(this.nextDate);
  DateTime nextDate;
}

class ChangeAipEvent extends PlannedWorkEvent {
  ChangeAipEvent(this.aipId);
  String? aipId;
}

class PostTaskEvidenceEvent extends PlannedWorkEvent {
  PostTaskEvidenceEvent(this.taskId, this.xFile);
  XFile xFile;
  String taskId;
}
