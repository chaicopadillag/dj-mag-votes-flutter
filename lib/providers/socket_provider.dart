import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum SocketStatus { Online, Offline, Connecting }

class SocketProvider with ChangeNotifier {
  late SocketStatus _socketStatus = SocketStatus.Connecting;
  late IO.Socket _socket;

  SocketProvider() {
    initConfig();
  }

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketStatus get socketStatus => _socketStatus;

  void initConfig() {
    Map<String, dynamic> options = IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        // .setExtraHeaders({'foo': 'bar'}) // optional
        .build();

    _socket = IO.io('http://192.168.1.110:8080', options);

    _socket.onConnect((_) {
      _socketStatus = SocketStatus.Online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _socketStatus = SocketStatus.Offline;
      notifyListeners();
    });
  }
}
