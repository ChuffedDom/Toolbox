import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Cost Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4747bf)),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const MyHomePage(title: 'App Cost Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _numberOfFeatures = 5;
  double _sizeOfTeam = 6;
  double _globalDistribution = 100;
  double _costOfApp = 17350;
  double _timeOfBuild = 4;
  int _selectedIndex = 0;

  void calcs() {
    // Time calculations
    var _hoursPerFeature = _numberOfFeatures * 106;
    var _hoursPerPerson = 1.4 * (_hoursPerFeature / _sizeOfTeam);
    // Higher Econmonic area costs
    var _heaFactor = _globalDistribution / 100;
    var _heaCost =
        3470 * _numberOfFeatures; // as if 100% is in higher economic areas
    var _heaFinalCost = _heaCost * _heaFactor;
    // Lower Economic area costs
    var _leaFactor = 1 - (_heaFactor);
    var _leaCost = _heaCost / 6; // as if 100% is in lower economic areas
    var _leaFinalCost = _leaCost * _leaFactor;
    setState(() {
      _timeOfBuild = _hoursPerPerson / 40;
      _costOfApp = _heaFinalCost + _leaFinalCost;
    });
  }

  TextStyle? numbersText() {
    if (MediaQuery.of(context).size.width < 410) {
      return Theme.of(context).textTheme.headlineSmall;
    } else {
      return Theme.of(context).textTheme.headlineMedium;
    }
  }

  int flexNumber() {
    if (MediaQuery.of(context).size.width < 400) {
      return 3;
    } else if (MediaQuery.of(context).size.width < 500) {
      return 4;
    } else if (MediaQuery.of(context).size.width < 680) {
      return 5;
    } else if (MediaQuery.of(context).size.width < 720) {
      return 6;
    } else if (MediaQuery.of(context).size.width < 780) {
      return 8;
    } else if (MediaQuery.of(context).size.width < 860) {
      return 9;
    } else {
      return 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,##0.00");
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "App Cost Calculator",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 8),
                  const Text(
                    'How much does it cost to build your app?',
                  ),
                  SizedBox(height: 64),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ToggleButtons(
                      isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                      onPressed: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      selectedColor: Theme.of(context).colorScheme.primary,
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("£"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("\$"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Size of app:",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: flexNumber(),
                        child: Slider(
                            value: _numberOfFeatures,
                            min: 3,
                            max: 10,
                            divisions: 7,
                            onChanged: (newValue) {
                              setState(() {
                                _numberOfFeatures = newValue;
                              });
                              calcs();
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              _numberOfFeatures.round().toString(),
                              style: numbersText(),
                            ),
                            Text(
                              "features",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Size of team:",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: flexNumber(),
                        child: Slider(
                            value: _sizeOfTeam,
                            min: 1,
                            max: 15,
                            divisions: 14,
                            onChanged: (newValue) {
                              setState(() {
                                _sizeOfTeam = newValue;
                              });
                              calcs();
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              _sizeOfTeam.round().toString(),
                              style: numbersText(),
                            ),
                            _sizeOfTeam == 1 ? Text("person") : Text("people")
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Global Distribution:",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: flexNumber(),
                        child: Slider(
                            value: _globalDistribution,
                            min: 0,
                            max: 100,
                            divisions: _sizeOfTeam.toInt(),
                            onChanged: (newValue) {
                              setState(() {
                                _globalDistribution = newValue;
                              });
                              calcs();
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            "${_globalDistribution.round()}%",
                            style: numbersText(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("in high economic regions"),
                        Text(
                            "${(100 - _globalDistribution).round()}% in low economic regions"),
                      ],
                    ),
                  ),
                  SizedBox(height: 64),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Your app will cost:"),
                        _selectedIndex == 0
                            ? Text(
                                "£" + formatter.format(_costOfApp),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "\$" + formatter.format(_costOfApp * 1.2674),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold),
                              ),
                        Text(
                          "and take ${_timeOfBuild.ceil()} weeks to build",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        // Text(MediaQuery.of(context).size.width.toString())
                        SizedBox(height: 16),
                        Text(
                          "note: all values are approximations",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
