import 'dart:convert';
import "dart:io";
import "dart:async";
import "dart:math";
import "package:dart_amqp/dart_amqp.dart";

var UUID = () => "${(new Random()).nextDouble()}";

class RPCClient {
    Client client;
    String queueTag;
    String _replyQueueTag;
    Completer contextChannel;
    Map<String, Completer> _channels = new Map<String, Completer>();
    Queue _queue;
    RPCClient() : client = new Client(),
        queueTag = "rpc_queue" {
        contextChannel = new Completer();
        client
        .channel()
        .then((Channel channel) => channel.queue(queueTag))
        .then((Queue rpcQueue) {
            _queue = rpcQueue;
            return rpcQueue.channel.privateQueue();
        })
        .then((Queue rpcQueue) {
            rpcQueue.consume(noAck: true)
                .then((Consumer consumer) {
                    _replyQueueTag = consumer.queue.name;
                    consumer.listen(handler);
                    contextChannel.complete();
                });
        });
    }

    void handler (AmqpMessage event) {
        if (!_channels
            .containsKey(
                event.properties.corellationId)) return;
        print(" [.] Got ${event.payloadAsString}");
        _channels
            .remove(event.properties.corellationId)
            .complete(event.payloadAsString);
    }

    Future<String> call(Map<String,Object> reqMap) {
        return contextChannel.future
            .then((_) {
                String uuid = UUID();
                Completer<String> channel = new Completer<String>();
                MessageProperties properties = new MessageProperties()
                    ..replyTo = _replyQueueTag
                    ..corellationId = uuid;
                _channels[uuid] = channel;
                print(" [x] Requesting ...");
                _queue.publish(reqMap, properties: properties);
                return channel.future;
            });
    }

    Future close() {
        _channels.forEach((_, var next) => next.complete("RPC client closed"));
        _channels.clear();
        client.close();
    }
}

Map<String, dynamic> parseResponse(String response) {

  final Map<String, dynamic> jsonResponse = json.decode(response);

  if (jsonResponse['_result'] != 0) {
    if (jsonResponse['message'] != null) {
      print(jsonResponse['message']);
    }
    if (jsonResponse['messages'] != null) {
      print(jsonResponse['messages']);
    }
  }

  return jsonResponse;
}

void main(List<String> arguments) {
    RPCClient client = new RPCClient();
    client.call({'_service': 'testScv',
          'defaultValue': 5.5,
          'message': "hello world"})
        .then((String res) {
            print(" [x] result = ${res}");
            var r=parseResponse(res);
            print(r['resp']);
        })
        .then((_) => client.close())
        .then((_) => null);
}


