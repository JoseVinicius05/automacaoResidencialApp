import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttSingleton {
  static final MqttSingleton _instance = MqttSingleton._internal();
  late MqttServerClient client;
  final String broker = 'broker.hivemq.com';
  final String clientId = 'bd0d0972-a4de-4b82-895b-1845b4fc59ab';

  bool conectado = false;

  factory MqttSingleton() {
    return _instance;
  }

  MqttSingleton._internal() {
    setupMqttClient();
  }

  void setupMqttClient() {
    client = MqttServerClient(broker, clientId);
    client.logging(on: true);
    client.setProtocolV311();

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    connect();
  }

  Future<void> connect() async {
    try {
      await client.connect();
    } catch (e) {
      print("Erro ao conectar: $e");
      client.disconnect();
      Future.delayed(const Duration(seconds: 5), () {
        connect();
      });
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print("Conectado ao broker MQTT");
      conectado = true;

    } else {
      print("Falha na conexão - Estado: ${client.connectionStatus!.state}");
      client.disconnect();
      Future.delayed(const Duration(seconds: 5), () {
        connect();
      });
    }
  }

  void onConnected() {
    print('Conexão estabelecida');
  }

  void onDisconnected() {
    print('Conexão perdida');
    Future.delayed(const Duration(seconds: 2), () {
      connect();
    });
  }

  void onSubscribed(String topic) {
    print('Inscrito no tópico: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Falha na inscrição ao tópico: $topic');
  }

  void pong() {
    print('Ping recebido');
  }

  void sendMessage(String topic, String message) {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    } else {
      print('Não é possível enviar a mensagem. Não conectado ao broker.');
    }
  }
}
