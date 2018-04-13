import 'package:gauge_flutter_app/src/canvas_api_client.dart';
import 'package:http_client/http_client.dart';
import 'package:http_client/console.dart';

class CanvasApiVmClient extends CanvasApiClient {
  CanvasApiVmClient(String domain) : super(domain);

  @override
  get client => new ConsoleClient();

}