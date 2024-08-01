import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseNotifier<T> extends Notifier<NotifierState<T>> {
  @override
  NotifierState<T> build() => const NotifierState();

  void init(bool reInit) {
    if (_hasInitialized && !reInit) return;
    _hasInitialized = true;
    onInit();
  }

  bool _hasInitialized = false;

  void onInit() {}

  void setLoading() {
    state = const NotifierState(status: NotifierStatus.loading);
  }

  void setIdle() {
    state = const NotifierState(status: NotifierStatus.idle);
  }

  void setData(T data) {
    state = NotifierState(status: NotifierStatus.done, data: data);
  }

  void setError(String message) {
    state = NotifierState(
      status: NotifierStatus.error,
      message: message,
    );
  }
}

class NotifierState<T> {
  final T? data;
  final NotifierStatus status;
  final String? message;
  const NotifierState({
    this.data,
    this.status = NotifierStatus.idle,
    this.message,
  });

  bool get isDone => status == NotifierStatus.done;
  bool get isLoading => status == NotifierStatus.loading;
  bool get isIdle => status == NotifierStatus.idle;
  bool get isError => status == NotifierStatus.error;
}

enum NotifierStatus { loading, idle, done, error }

NotifierState<T> notifyData<T>({required T? value}) {
  return NotifierState<T>(
    status: NotifierStatus.done,
    data: value,
  );
}

NotifierState<T> notifyError<T>({required String error}) {
  return NotifierState<T>(
    status: NotifierStatus.error,
    message: error,
  );
}

typedef FutureNotifierState<T> = Future<NotifierState<T>>;
