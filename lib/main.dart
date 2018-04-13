import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gauge_flutter_app/src/canvas_api_vm_client.dart';
import 'package:gauge_flutter_app/src/oauth2_helper.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Gauge',
        theme: new ThemeData.dark(
//          primarySwatch: Colors.blue,  TODO: Switch to canvas color
            ),
        routes: {'/': (_) => new GaugeWebView()});
  }
}

class GaugeWebViewState extends State<GaugeWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    _asyncInitState().catchError(print);
  }

  _asyncInitState() async {
    var devKeyConfig = await _getDeveloperKeyConfig();
    var oAuthHelper = new OAuth2Helper(
        'gauge-edge', devKeyConfig['clientId'], devKeyConfig['secret']);

    _setupWebViewListeners(oAuthHelper).catchError(print);
    flutterWebviewPlugin.launch(oAuthHelper.redirectUrl);
  }

  _getDeveloperKeyConfig() async {
    String jsonString =
        await rootBundle.loadString('assets/canvas-developer-key.json');
    return json.decode(jsonString);
  }

  _setupWebViewListeners(oAuthHelper) async {
    var url = await flutterWebviewPlugin.onUrlChanged.firstWhere(
        (url) => Uri.parse(url).queryParameters.containsKey('code'));
    var code = Uri.parse(url).queryParameters['code'];
    var tokenResults = await oAuthHelper.getToken(code);
    var sld = await _getSessionLaunchDetails(tokenResults);

//    flutterWebviewPlugin.launch(sld.url);
    flutterWebviewPlugin.evalJavascript('window.location.href="${sld.url}"');
  }

  _getSessionLaunchDetails(TokenResults tokenResults) async {
    var client = new CanvasApiVmClient('gauge-edge');
    var token = tokenResults.accessToken;
    var user = tokenResults.user;
    var accounts = await client.getAccounts(token);
    if (accounts.isEmpty) {
      return await _getSessionLaunchDetailsByCourses(client, token, user);
    } else {
      return await _getSessionLaunchDetailsByAccount(client, token);
    }
  }

  _getSessionLaunchDetailsByAccount(client, token) async {
    var externalTools = await client.getExternalToolsForAccount(token);
    var gauge = externalTools.firstWhere(isGaugeExternalTool);
    return await client.getExternalToolSessionlessLaunchDetailsForAccount(
        token, gauge.url);
  }

  _getSessionLaunchDetailsByCourses(client, token, user) async {
    var courses = await client.getCoursesForUser(token, user.id);
    var courseId = courses.first.id;
    var externalTools = await client.getExternalToolsForCourse(token, courseId,
        includeParents: true);
    var gauge = externalTools.firstWhere(isGaugeExternalTool);
    return await client.getExternalToolSessionlessLaunchDetailsForCourse(
        token, courseId, gauge.url);
  }

  bool isGaugeExternalTool(et) => et.domain == 'gauge.instructure.com';

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    flutterWebviewPlugin.resize(new Rect.fromLTWH(
        0.0,
        statusBarHeight,
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - statusBarHeight));
    return new Container();
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}

class GaugeWebView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GaugeWebViewState();
}
