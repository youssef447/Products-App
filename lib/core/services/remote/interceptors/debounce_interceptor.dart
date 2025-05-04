import 'dart:async';
import 'package:dio/dio.dart';

class DebounceInterceptor extends Interceptor {
  final Duration debounceTime = const Duration(seconds: 1);
  Timer? _debounceTimer;
  CancelToken? _lastCancelToken;

  DebounceInterceptor();

  bool _shouldDebounce(RequestOptions options) {
    return options.path.contains('/search');
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (_shouldDebounce(options)) {
      // Debounce logic
      _lastCancelToken?.cancel("Cancelled due to new request");
      _debounceTimer?.cancel();

      _lastCancelToken = CancelToken();
      options.cancelToken = _lastCancelToken;

      _debounceTimer = Timer(debounceTime, () {
        super.onRequest(options, handler);
      });
    } else {
      super.onRequest(options, handler);
    }
  }
}
