part of 'planned_work_bloc.dart';

abstract class PlannedWorkEvent {}

class InitScreenEvent extends PlannedWorkEvent {
  InitScreenEvent();
}

class ChangeDateTimeEvent extends PlannedWorkEvent {
  ChangeDateTimeEvent(this.nextDate);
  DateTime nextDate;
}

class ChangeAipEvent extends PlannedWorkEvent {
  ChangeAipEvent(this.aipId);
  String? aipId;
}

class ResetStateEvent extends PlannedWorkEvent {
  ResetStateEvent();
}

class StateLoadedEvent extends PlannedWorkEvent {
  StateLoadedEvent();
}

class PostTaskEvidenceEvent extends PlannedWorkEvent {
  PostTaskEvidenceEvent(this.taskId, this.xFile);
  XFile xFile;
  String taskId;
}
