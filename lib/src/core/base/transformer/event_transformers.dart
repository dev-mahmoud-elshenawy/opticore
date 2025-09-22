part of '../import/base_import.dart';

/// A debounce transformer that delays event processing
EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) {
    return events
        .transform(_DebounceStreamTransformer<E>(duration))
        .asyncExpand(mapper);
  };
}

/// Custom debounce stream transformer
class _DebounceStreamTransformer<T> extends StreamTransformerBase<T, T> {
  final Duration duration;

  const _DebounceStreamTransformer(this.duration);

  @override
  Stream<T> bind(Stream<T> stream) {
    Timer? timer;
    late StreamController<T> controller;
    StreamSubscription<T>? subscription;

    controller = StreamController<T>(
      onListen: () {
        subscription = stream.listen(
          (T data) {
            timer?.cancel();
            timer = Timer(duration, () {
              controller.add(data);
            });
          },
          onError: controller.addError,
          onDone: () {
            timer?.cancel();
            controller.close();
          },
        );
      },
      onCancel: () {
        timer?.cancel();
        subscription?.cancel();
      },
    );

    return controller.stream;
  }
}

/// A sequential transformer for processing events one by one
EventTransformer<E> sequential<E>() {
  return (events, mapper) => events.asyncExpand(mapper);
}

/// Predefined debounce transformers for common use cases

/// Fast debounce - for immediate user interactions (200ms)
EventTransformer<E> fastDebounce<E>() =>
    debounce(const Duration(milliseconds: 200));

/// Standard debounce - for search inputs (400ms)
EventTransformer<E> standardDebounce<E>() =>
    debounce(const Duration(milliseconds: 400));

/// Slow debounce - for heavy operations (800ms)
EventTransformer<E> slowDebounce<E>() =>
    debounce(const Duration(milliseconds: 800));

/// Very slow debounce - for API-intensive operations (1500ms)
EventTransformer<E> verySlowDebounce<E>() =>
    debounce(const Duration(milliseconds: 1500));
