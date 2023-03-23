import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

//ignore: non_constant_identifier_names, use_function_type_syntax_for_parameters

//import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Outfit'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tutorial',
      home: const TutorialHome(),
    ),
  );
}

class TutorialHome extends StatelessWidget {
  const TutorialHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6699CC),
        elevation: 0,
        toolbarHeight: kToolbarHeight + 8,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(fontFamily: 'Fasthand', fontSize: 28),
        ),
        centerTitle: true,
      ),
      // body is the majority of the screen.
      body: const Center(
        child: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  Color statusColor = Colors.black;
  void checkStatus(double result) {
    if (result <= 18) {
      setState(() {
        status = "Underweight";
        statusColor = Colors.blue;
      });
    } else if (result < 25) {
      setState(() {
        status = "Healthy";
        statusColor = Colors.green;
      });
    } else if (result < 30) {
      setState(() {
        status = "Overweight";
        statusColor = Colors.yellow;
      });
    } else if (result < 40) {
      setState(() {
        status = "Obese";
        statusColor = Colors.orange;
      });
    } else {
      setState(() {
        status = "Extremely Obese";
        statusColor = Colors.red;
      });
    }
  }

  var status = "TBD";
  // ignore: non_constant_identifier_names
  late int BMI;
  @override
  void dispose() {
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: 0,
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Height :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: TextField(
              controller: myController1,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                // ignore: prefer_const_constructors
                border: OutlineInputBorder(),
                hintText: 'Enter your Height(meter)',
                suffix: const Text('m'),
              ),
              style: const TextStyle(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              onChanged: (height) {
                if (double.tryParse(height) != null) {
                  final result = double.parse(myController2.text) /
                      (double.parse(height) * double.parse(height));
                  checkStatus(result);
                  myController3.text = result.toStringAsPrecision(4);
                } else {
                  setState(() {
                    status = "";
                    statusColor = Colors.black;
                  });
                  myController3.text = '';
                }
              }),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Weight :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: TextField(
              controller: myController2,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                // ignore: prefer_const_constructors
                border: OutlineInputBorder(),
                hintText: 'Enter your Weight(kg)',
                suffix: const Text('kg'),
              ),
              style: const TextStyle(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              onChanged: (weight) {
                if (double.tryParse(weight) != null) {
                  final result = double.parse(weight) /
                      (double.parse(myController1.text) *
                          double.parse(myController1.text));
                  checkStatus(result);
                  myController3.text = result.toStringAsPrecision(4);
                } else {
                  setState(() {
                    status = "";
                    statusColor = Colors.black;
                  });
                  myController3.text = '';
                }
              }),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Age :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Age',
            ),
            style: TextStyle(fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,

          )
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'BMI :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: TextField(
            controller: myController3,
            // ignore: prefer_const_constructors
            decoration: InputDecoration(
              // ignore: prefer_const_constructors
              border: OutlineInputBorder(),
              hintText: 'BMI',
            ),
            style: const TextStyle(fontWeight: FontWeight.bold),
            keyboardType: TextInputType.none,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              const Text(
                'Status: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                status,
                style: TextStyle(
                    fontSize: 16,
                    color: statusColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}
