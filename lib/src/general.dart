part of hangouts_api;

class HangoutAPIException implements Exception {
  final String msg;
  const HangoutAPIException([this.msg]);
  String toString() => (msg == null) ? "HangoutAPIException" : "HangoutAPIException: $msg";
}

String simpleStringCall(List<String> name) {
  String value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    value = ns();
  });
  return value;
}

bool simpleBoolCall(List<String> name) {
  bool value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    value = ns();
  });
  return value;
}

void simpleVoidCall(List<String> name) {
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    ns();
  });
}

List simpleListCall(List<String> name) {
  List value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    value = ns();
  });
  return value;
}