import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = 'Preencha os valores';
  TextEditingController etanolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _reset() {
    etanolController.text = '';
    gasolinaController.text = '';

    setState(() {
      _resultado = 'Preencha os valores';
    });
  }

  void _calculaCombustivelIdeal() {
    double vEtanol = double.parse(etanolController.text.replaceAll(',', '.'));
    double vGasolina =
        double.parse(gasolinaController.text.replaceAll(',', '.'));
    double proporcao = vEtanol / vGasolina;

    setState(() {
      _resultado =
          (proporcao <= 0.7) ? 'Abasteça com Etanol' : 'Abasteça com Gasolina';

      //é o mesmo que:
      // if (proporcao <= 0.7) {
      //   _resultado = 'Abasteça com Etanol;
      // } else {
      //   _resultado = 'Abasteça com Gasolina';
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gasolina ou Etanol?',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  Icon(
                    Icons.local_gas_station,
                    size: 140,
                    color: Colors.lightGreen[900],
                  ),
                  //Parou Aqui
                  // IconButton(
                  //     iconSize: 100,
                  //     //padding: const EdgeInsets.all(0.0),
                  //     //color: Colors.lightBlue[900],
                  //     icon: Image.asset('assets/refresh_gas.png'),
                  //     onPressed: _reset),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: etanolController,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o valor do Etanol';
                      }
                      return null;
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Valor do Etanol',
                      labelStyle: TextStyle(color: Colors.lightGreen[900]),
                    ),
                    style:
                        TextStyle(color: Colors.lightGreen[900], fontSize: 26),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: gasolinaController,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o valor da Gasolina';
                        }
                        return null;
                      },
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                          labelText: 'Valor da Gasolina',
                          labelStyle: TextStyle(color: Colors.lightGreen[900])),
                      style: TextStyle(
                          color: Colors.lightGreen[900], fontSize: 26)),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen[900]),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _calculaCombustivelIdeal();
                                }
                              },
                              child: const Text(
                                'Verificar',
                                style: TextStyle(fontSize: 25),
                              )))),
                  Text(_resultado,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.lightGreen[900], fontSize: 26))
                ]))));
  }
}
