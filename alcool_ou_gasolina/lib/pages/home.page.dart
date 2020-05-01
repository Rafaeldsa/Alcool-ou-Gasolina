

import 'package:alcool_ou_gasolina/widgets/logo.widget.dart';
import 'package:alcool_ou_gasolina/widgets/submit-form.dart';
import 'package:alcool_ou_gasolina/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  Color color = Colors.green;
  var gasCtrl = new MoneyMaskedTextController();
  var alcCtrl = new MoneyMaskedTextController();
  var busy = false;
  var completed = false;
  var resultText = "Compensa utilizar álcool";  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        duration: Duration(
          milliseconds: 1200,
        ),
        color: color,
      child: ListView(
        children: <Widget>[
          Logo(), 
          completed ? Success(
            reset: reset,
          result: resultText,)  
          :         
          SubmitForm(alcCtrl: alcCtrl, gasCtrl: gasCtrl,
          submitFunc: calculate,
          busy: false),
          
          
        ],
      ),
    );
  }

  Future calculate() {
    double alc =
        double.parse(alcCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    double gas =
        double.parse(gasCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    double res = alc / gas;

    setState(() {
      color = Colors.deepPurpleAccent;
      completed = false;
      busy = true;
    });

    return new Future.delayed(
        const Duration(seconds: 1),
        () => {
              setState(() {
                if (res >= 0.7) {
                  resultText = "Compensa utilizar Gasolina!";
                } else {
                  resultText = "Compensa utilizar Álcool!";
                }

                busy = false;
                completed = true;
              })
            });
  }

  reset() {
    setState(() {
      color = Colors.deepPurple;
      alcCtrl = new MoneyMaskedTextController();
      gasCtrl = new MoneyMaskedTextController();
      completed = false;
      busy = false;
    });
  }
}

