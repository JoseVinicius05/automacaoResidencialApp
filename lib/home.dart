// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:casa_inteligente/mqtt/singletonMQTT.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final mqttSingleton = MqttSingleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 26, 26),
        title: const Text(
          "Controle Residencial",
          style: TextStyle(color: Color.fromARGB(255, 169, 169, 169)),
        ),
      ),
      body: Container(
          color: const Color.fromRGBO(55, 51, 51, 1),
          child: ListView(
            children: const [
              Card(Icons.chair, "Sala de estar", 1),
              Card(Icons.cookie_outlined, "Cozinha", 2),
              Card(Icons.bathtub, "Banheiro", 3),
              Card(Icons.king_bed_outlined, "Quarto 1", 4),
              Card(Icons.king_bed_outlined, "Quarto 2", 5),
              Card(FontAwesomeIcons.arrowRightFromBracket, "Área externa",8),
              Card(FontAwesomeIcons.dungeon, "Portão Grande", 6),
              Card(FontAwesomeIcons.dungeon, "Portão\nPequeno", 7),
            ],
          )),
    );
  }
}

class Card extends StatefulWidget {
  final String tituloCard;
  final IconData icone;
  final int NmrCard;

  const Card(this.icone, this.tituloCard, this.NmrCard, {super.key});

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  final mqttSingleton = MqttSingleton();

  void sendMessage(String atividade, int nmr) {
    const String topic = 'teste/sala1';
    final String message = '$atividade $nmr';
    mqttSingleton.sendMessage(topic, message);
  }

  bool ligado = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: const Color.fromARGB(221, 29, 28, 28),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color.fromARGB(228, 0, 119, 170),
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        width: 90,
                        height: 90,
                        child: Icon(
                          size: 40,
                          widget.icone,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        widget.tituloCard,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if(widget.NmrCard==7){
                                setState(() {
                                  ligado = !ligado;
                                }); 
                                Future.delayed(const Duration(seconds: 1),(){
                                  setState(() {
                                    ligado = !ligado;
                                  });
                                });
                              }else{
                                ligado = !ligado;
                              }
                            });
                            ligado
                                ? sendMessage("on", widget.NmrCard)
                                : sendMessage("off", widget.NmrCard);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ligado
                                ? Colors.amber
                                : const Color.fromARGB(
                                    255, 20, 20, 20), // Fundo preto do botão
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Borda arredondada
                            ),
                            minimumSize: const Size(90, 90),
                          ),
                          child: iconeBotao(widget.NmrCard),
                        )),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Icon iconeBotao(int nmr) {
  if (nmr == 6 || nmr == 7) {
    return const Icon(
      size: 40,
      FontAwesomeIcons.doorOpen,
      color: Colors.white,
    );
  } else {
    return const Icon(
      size: 40,
      Icons.lightbulb,
      color: Colors.white,
    );
  }
}
