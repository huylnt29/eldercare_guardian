part of 'schedule_bloc.dart';

abstract class ScheduleEvent {}

class InitScreenEvent extends ScheduleEvent {
  InitScreenEvent();
}

class ChangeDateTimeEvent extends ScheduleEvent {
  ChangeDateTimeEvent(this.nextDate);
  DateTime nextDate;
}

class ChangeAipEvent extends ScheduleEvent {
  ChangeAipEvent(this.aipId);
  String? aipId;
}

class ResetStateEvent extends ScheduleEvent {
  ResetStateEvent();
}

class StateLoadedEvent extends ScheduleEvent {
  StateLoadedEvent();
}

class PostTaskEvidenceEvent extends ScheduleEvent {
  PostTaskEvidenceEvent(this.taskId, this.xFile);
  XFile xFile;
  String taskId;
}
