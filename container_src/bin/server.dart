import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  final handler = Pipeline().addHandler((req) => Response.ok('''
Welcome to the Dart server!

Request Method: ${req.method}
Request Path: ${req.requestedUri.path}
Request Headers: ${JsonEncoder.withIndent('  ').convert(req.headers)}
Request Query Parameters: ${JsonEncoder.withIndent('  ').convert(req.requestedUri.queryParameters)}
'''));

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
