part of hangouts_api;

class HangoutAPIException implements Exception {
  final String msg;
  const HangoutAPIException([this.msg]);
  String toString() => (msg == null) ? "HangoutAPIException" : "HangoutAPIException: $msg";
}

String makeStringCall(List<String> name, [List params = const []]) {
  String value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    switch (params.length) {
      case 0: value = ns(); break;
      case 1: value = ns(params[0]); break;
      default: value = ns(params[0], params[1]); break;
    }
  });
  return value;
}

num makeNumCall(List<String> name, [List params = const []]) {
  num value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    switch (params.length) {
      case 0: value = ns(); break;
      case 1: value = ns(params[0]); break;
      default: value = ns(params[0], params[1]); break;
    }
  });
  return value;
}


bool makeBoolCall(List<String> name, [List params = const []]) {
  bool value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    switch (params.length) {
      case 0: value = ns(); break;
      case 1: value = ns(params[0]); break;
      default: value = ns(params[0], params[1]); break;
    }
  });
  return value;
}

void makeVoidCall(List<String> name, [List params = const []]) {
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    switch (params.length) {
      case 0: ns(); break;
      case 1: ns(params[0]); break;
      default: ns(params[0], params[1]); break;
    }
  });
}

js.Proxy makeProxyCall(List<String> name, [List params = const []]) {
  js.Proxy value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    switch (params.length) {
      case 0: value = ns(); break;
      case 1: value = ns(params[0]); break;
      default: value = ns(params[0], params[1]); break;
    }
    js.retain(value);
  });
  return value;
}