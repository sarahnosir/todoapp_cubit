import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class Todo {
  final String title;
  final bool isCompleted;

  Todo(this.title, {this.isCompleted = false});

  Todo copyWith({String? title, bool? isCompleted}) {
    return Todo(
      title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState(this.todos);

  @override
  List<Object?> get props => [todos];
}

abstract class TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;

  AddTodo(this.title);
}

class ToggleTodo extends TodoEvent {
  final int index;

  ToggleTodo(this.index);
}

class ClearCompleted extends TodoEvent {}

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState([]));

  void addTodo(String title) {
    final newTodos = [
      ...state.todos,
      Todo(title),
    ];
    emit(TodoState(newTodos));
  }

  void toggleTodo(int index) {
    final newTodos = List<Todo>.from(state.todos);
    newTodos[index] =
        newTodos[index].copyWith(isCompleted: !newTodos[index].isCompleted);
    emit(TodoState(newTodos));
  }

  void clearCompleted() {
    final newTodos = List<Todo>.from(
        state.todos.where((todo) => !todo.isCompleted).toList());
    emit(TodoState(newTodos));
  }
}
