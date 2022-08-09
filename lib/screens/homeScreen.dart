import 'package:flutter/material.dart';
import 'package:tip_calculator/utillities/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _billAmount = 0.0;
  int _personCounter = 1;
  late int _tipPercentage = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height *
            0.04), //dynamic hight on any device
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          // padding: const EdgeInsets.only(
          //     top: 40.0, left: 20.0, right: 20.0, bottom: 20.0), better way with midia Query
          padding: const EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Per Person',
                      style: TextStyle( 
                          color: Colors.purple.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.grey.shade300.withOpacity(0.6),
                    ),
                    Text(
                      '\$ ${calculateTotalPerPerson(_billAmount,_personCounter)}',
                      style: kMainLableTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    color: Colors.blueGrey.shade100, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(11.0),
              ),
              child: Column(
                children: [
                  //textField
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.purple.shade300),
                    decoration: const InputDecoration(
                      prefixText: "Bill Amount: ",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (e) {
                        _billAmount = 0.0;
                        var snackBar = SnackBar(
                          content: const Text(
                            'Incorrect Input',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor:
                              Colors.purple.shade200.withOpacity(0.6),
                          elevation: 30.0,
                          duration: const Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // the Split functinality
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Split',
                        style: kLabaleTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {
                                  //another SnackBard here
                                }
                              });
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.shade200,
                              ),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.purple.shade300,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 30.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          Text(
                            "$_personCounter",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 25.0),
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter < 100) {
                                  _personCounter++;
                                } else {
                                  //another SnackBar here
                                }
                              });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.purple.shade300,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w900),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // Tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tip',
                        style: kLabaleTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "\$ ${(calaculateTip(_billAmount, _tipPercentage).toStringAsFixed(2))}",
                          style: TextStyle(
                              color: Colors.purple.shade300,
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$_tipPercentage%",
                        style: kMainLableTextStyle,
                      ),
                      Slider(
                        value: _tipPercentage.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            _tipPercentage = value.round();
                          });
                        },
                        min: 0,
                        max: 100,
                        divisions: 10,
                        inactiveColor: Colors.purple.shade100,
                        activeColor: Colors.purple.shade400,
                        autofocus: true,
                        thumbColor: Colors.purple.shade800,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson( double billAmount, int splitBy) {
    double totalTip = calaculateTip(_billAmount, _tipPercentage);
    double totalPerPerson = 0.0;

    totalPerPerson = (totalTip + billAmount) / splitBy;

    return totalPerPerson.toStringAsFixed(2);
  }

  calaculateTip(double billAmount, int tipPercentage) {
    double totalTip = 0.0;

    if (billAmount == 0 || billAmount.toString().isEmpty) {
      // SnackBar
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }

    return totalTip;
  }
}
