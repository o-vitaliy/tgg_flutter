import 'dart:convert';
import 'dart:io';

enum httpMethod { get, post, put }

Future<String> apiRequest(
  String url, {
  Map params,
  String token,
  httpMethod method = httpMethod.post,
}) async {
  HttpClient httpClient = HttpClient();
  HttpClientRequest request =
      await sendClientRequest(httpClient, Uri.parse(url), method);
  if (token != null) request.headers.set('Authorization', 'Token $token');
  sendParams(request, params, method);
  HttpClientResponse response = await request.close();
  try {
    final reply = await response.transform(utf8.decoder).join();
    print("request: $url \n ${json.encode(params)} \n ${request.headers}");
    print("response ${response.statusCode} : $reply");
    if (response.statusCode < 400) {
      return reply;
    } else {
      if (isJson(reply)) {
        final String errors =
            Map<String, dynamic>.from(json.decode(reply)).values.expand((v) {
          if (v is String)
            return List.of([v]);
          else
            return List<String>.from(v.map((e) => e as String));
        }).join(", ");
        throw ArgumentError(errors);
      } else {
        throw ArgumentError("Internal server error");
      }
    }
  } catch (error) {
    print(error);
    throw error;
  } finally {
    httpClient.close();
  }
}

Future<HttpClientRequest> sendClientRequest(
    HttpClient httpClient, Uri url, httpMethod method) {
  switch (method) {
    case httpMethod.post:
      return httpClient.postUrl(url);
    case httpMethod.put:
      return httpClient.putUrl(url);
    case httpMethod.get:
      return httpClient.getUrl(url);
    default:
      throw Exception("missed implemention of $method");
  }
}

void sendParams(HttpClientRequest request, Map jsonMap, httpMethod method) {
  switch (method) {
    case httpMethod.post:
    case httpMethod.put:
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(jsonMap)));
      break;
    default:
      break;
  }
}

bool isJson(String response) {
  try {
    json.decode(response);
    return true;
  } catch (_) {
    return false;
  }
}
