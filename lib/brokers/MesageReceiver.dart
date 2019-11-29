import 'package:dart_amqp/dart_amqp.dart';
import 'package:catalog/constants.dart' as cons;

class MessageReceiver{
  Client client;
  void init(){
    ConnectionSettings settings=ConnectionSettings(host: cons.serverHost);
    // ConnectionSettings settings=ConnectionSettings(host: cons.serverHost,
    //    authProvider:const PlainAuthenticator("test", "test"));
    client = new Client(settings: settings);

    client
        .channel()
        .then((Channel channel) => channel.queue("hello"))
        .then((Queue queue) => queue.consume())
        .then((Consumer consumer) {
      print(" [*] MessageReceiver waiting for messages..");
      consumer.listen((AmqpMessage message) {
        print(" [x] Received ${message.payloadAsString}");
      });
    });
  }

  void dispose(){
    client.close().then((_) {
      print("exit.");
    });
  }
}

