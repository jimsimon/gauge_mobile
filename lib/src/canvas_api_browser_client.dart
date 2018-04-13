import 'package:gauge_flutter_app/src/canvas_api_client.dart';
import 'package:http_client/http_client.dart';
import 'package:http_client/browser.dart';

class CanvasApiBrowserClient extends CanvasApiClient {
  CanvasApiBrowserClient(String domain) : super(domain);

  @override
  Client get client => new BrowserClient();

}