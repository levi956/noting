import 'base_notifier.dart';
import 'service_response.dart';

Future<NotifierState<Response>> convert<Response>(
  MainFunction<Response> f, {
  Function(ServiceResponse<Response>)? then,
}) async {
  var response = await f();
  then?.call(response);
  return response.toNotifierState();
}

typedef MainFunction<Response> = Future<ServiceResponse<Response>> Function();
