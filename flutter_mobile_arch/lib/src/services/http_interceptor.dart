import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/services/service_locator.dart';
import 'package:flutter_mobile_arch/src/services/token_service.dart';
import 'package:http/http.dart' as http;

class HttpInterceptor {
  Locale deviceLocale = WidgetsBinding.instance.window.locale;

  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  Future<http.BaseRequest> interceptRequest(http.BaseRequest request) async {
    final tokenService = getIt<TokenService>();
    String lang = deviceLocale.languageCode.toString();
    _headers['lang'] = lang;
    request.headers.addAll(_headers);
    final accessToken = await tokenService.getAccessToken();
    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }
    _printInChunks('Request: ${request.method} ${request.url}');
    _printInChunks('Headers: ${_formatJsonHeader(request.headers)}');

    if (request is http.Request) {
      _printInChunks('Body: ${_formatJson(request.body)}');
    } else if (request is http.MultipartRequest) {
      _logMultipartRequest(request);
    }

    return request;
  }

  Future<http.StreamedResponse> interceptResponse(
      http.StreamedResponse response) async {
    final responseHeaders = response.headers;
    final responseStatusCode = response.statusCode;
    final responseBody = await response.stream.bytesToString();
    _printInChunks('Response Status: $responseStatusCode');
    _printInChunks('Response Headers: ${_formatJsonHeader(responseHeaders)}');
    _printInChunks('Response Body: ${_formatJson(responseBody)}');

    return http.StreamedResponse(
      Stream.value(utf8.encode(responseBody)),
      responseStatusCode,
      headers: responseHeaders,
    );
  }

  void _logMultipartRequest(http.MultipartRequest request) {
    _printInChunks(
        'Multipart Request Fields: ${_formatJson(json.encode(request.fields))}');
    for (var file in request.files) {
      _printInChunks(
          'Multipart Request File: ${file.filename} (${file.contentType})');
    }
  }

  String _formatJson(String jsonString) {
    try {
      final jsonObject = jsonDecode(jsonString);
      return const JsonEncoder.withIndent('  ').convert(jsonObject);
    } catch (e) {
      return jsonString;
    }
  }

  String _formatJsonHeader(Map<String, String> jsonMap) {
    return const JsonEncoder.withIndent('  ').convert(jsonMap);
  }

  void _printInChunks(String text) {
    const int chunkSize = 1000;
    for (int i = 0; i < text.length; i += chunkSize) {

    }
  }
}
