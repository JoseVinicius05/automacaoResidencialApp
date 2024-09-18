import 'package:casa_inteligente/home.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController raController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 55, 51, 51),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: const Color.fromARGB(221, 29, 28, 28),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text("Login", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: 
                          SizedBox(
                            width: 250,
                            height: 50,
                            child: TextFormField(
                            controller: raController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Color.fromARGB(227, 184, 234, 255),
                              filled: true,
                              label: Text(
                                "RA",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            onEditingComplete: () {},
                          ) ,)
                         
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:
                          SizedBox(
                            width: 250,
                            height: 50,
                            child:
                           TextFormField(
                            controller: senhaController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Color.fromARGB(227, 184, 234, 255),
                              filled: true,
                              label: Text(
                                "Senha",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            onEditingComplete: () {},
                          ),),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 3, 82, 147),
                                    ),
                                  ),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.all(16.0),
                                      textStyle: const TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const TelaInicial(),
                                          ));
                                    },
                                    child: const Text("Entrar"))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
