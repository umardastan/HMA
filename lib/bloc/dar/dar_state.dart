import 'package:equatable/equatable.dart';
import 'package:login/model/task.dart';
import 'package:login/model/user.dart';

class DarState extends Equatable {
  final User user;
  final Task task;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final List<Task> tasks;
  final String warningMessage;

  // TaskState({required this.tasks, this.warningMessage = ''});

  DarState({
    User? user,
    Task? task,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.warningMessage = '',
    this.tasks = const <Task>[],
  })  : user = user ?? User(),
        task = task ?? Task();

  DarState copyWith({
    User? user,
    Task? task,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<Task>? tasks,
    String? warningMessage,
  }) {
    return DarState(
      user: user ?? this.user,
      task: task ?? this.task,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      tasks: tasks ?? this.tasks, // Update field tasks di sini
      warningMessage: warningMessage ?? this.warningMessage,
    );
  }

  @override
  List<Object> get props =>
      [user, task, isLoading, isSuccess, errorMessage, tasks, warningMessage];
}
