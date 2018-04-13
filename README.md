# Gauge Mobile

An experimental webview based mobile app for Gauge AMS using [Flutter](https://flutter.io/).

This application uses the Canvas REST API to authenticate a user and then execute an LTI launch into Gauge via a webview.

DISCLAIMER: This application is not officially supported by Instructure.  It is not intended for production use and any support requests will most likely be ignored.

## Getting Started

1. Install and configure [Flutter](https://flutter.io/)
2. [Provision a Canvas Developer Key](https://canvas.instructure.com/doc/api/file.oauth.html#oauth2-flow-0) client id and secret
3. Create `assets/canvas-developer-key.json` with the following contents:
    ```json
    {
      "clientId": "<your client id goes here>",
      "secret": "<your secreat goes here>"
    }
    ```
4. Make sure you have one or more devices connected (or emulators running)
5. Run `flutter run -d all` to build, install, and launch the app on all connected devices/emulators

## Potential Future Enhancements
* Allow user to specify their shard/domain (current hard-coded to `gauge-edge.instructure.com`)
* Move portions of the Gauge UI to native code and use deep linked LTI launches for build/take/moderate/etc experiences