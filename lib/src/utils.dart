part of hangouts_api;

class HangoutAPIException implements Exception {
  final String msg;
  const HangoutAPIException([this.msg]);
  String toString() => (msg == null) ? "HangoutAPIException" : "HangoutAPIException: $msg";
}

js.Proxy _createParamProxy(param) {
  if (param is List) return js.array(param);
  if (param is Map) return js.map(param);
  return param;
}

abstract class ProxyObject {
  js.Proxy _proxy;
  
  ProxyObject._internal(js.Proxy this._proxy);
  
  String _makeStringCall(String name, [List params = const []]) {
    String value;
    js.scoped(() {
      switch (params.length) {
        case 0: value = _proxy[name](); break;
        case 1: value = _proxy[name](_createParamProxy(params[0])); break;
        default: value = _proxy[name](_createParamProxy(params[0]), _createParamProxy(params[1])); break;
      }
    });
    return value;
  }

  num _makeNumCall(String name, [List params = const []]) {
    num value;
    js.scoped(() {
      switch (params.length) {
        case 0: value = _proxy[name](); break;
        case 1: value = _proxy[name](_createParamProxy(params[0])); break;
        default: value = _proxy[name](_createParamProxy(params[0]), _createParamProxy(params[1])); break;
      }
    });
    return value;
  }

  bool _makeBoolCall(String name, [List params = const []]) {
    bool value;
    js.scoped(() {
      switch (params.length) {
        case 0: value = _proxy[name](); break;
        case 1: value = _proxy[name](_createParamProxy(params[0])); break;
        default: value = _proxy[name](_createParamProxy(params[0]), _createParamProxy(params[1])); break;
      }
    });
    return value;
  }

  void _makeVoidCall(String name, [List params = const []]) {
    js.scoped(() {
      switch (params.length) {
        case 0: _proxy[name](); break;
        case 1: _proxy[name](_createParamProxy(params[0])); break;
        default: _proxy[name](_createParamProxy(params[0]), _createParamProxy(params[1])); break;
      }
    });
  }

  js.Proxy _makeProxyCall(String name, [List params = const []]) {
    js.Proxy value;
    js.scoped(() {
      switch (params.length) {
        case 0: value = _proxy[name](); break;
        case 1: value = _proxy[name](_createParamProxy(params[0])); break;
        default: value = _proxy[name](_createParamProxy(params[0]), _createParamProxy(params[1])); break;
      }
      js.retain(value);
    });
    return value;
  } 
}

String _makeStringCall(List<String> name, [List params = const []]) {
  String value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    switch (params.length) {
      case 0: value = ns(); break;
      case 1: value = ns(_createParamProxy(params[0])); break;
      default: value = ns(_createParamProxy(params[0]), _createParamProxy(params[1])); break;
    }
  });
  return value;
}

num _makeNumCall(List<String> name, [List params = const []]) {
  num value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    switch (params.length) {
      case 0: value = ns(); break;
      case 1: value = ns(_createParamProxy(params[0])); break;
      default: value = ns(_createParamProxy(params[0]), _createParamProxy(params[1])); break;
    }
  });
  return value;
}

bool _makeBoolCall(List<String> name, [List params = const []]) {
  bool value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    switch (params.length) {
      case 0: value = ns(); break;
      case 1: value = ns(_createParamProxy(params[0])); break;
      default: value = ns(_createParamProxy(params[0]), _createParamProxy(params[1])); break;
    }
  });
  return value;
}

void _makeVoidCall(List<String> name, [List params = const []]) {
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    switch (params.length) {
      case 0: ns(); break;
      case 1: ns(_createParamProxy(params[0])); break;
      default: ns(_createParamProxy(params[0]), _createParamProxy(params[1])); break;
    }
  });
}

js.Proxy _makeProxyCall(List<String> name, [List params = const []]) {
  js.Proxy value;
  js.scoped(() {
    var ns = js.context.gapi.hangout;
    name.forEach((s) {
      ns = ns[s];
    });
    switch (params.length) {
      case 0: value = ns(); break;
      case 1: value = ns(_createParamProxy(params[0])); break;
      default: value = ns(_createParamProxy(params[0]), _createParamProxy(params[1])); break;
    }
    js.retain(value);
  });
  return value;
}