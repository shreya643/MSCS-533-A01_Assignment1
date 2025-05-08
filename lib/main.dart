import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UnitConverter(),
    );
  }
}

class UnitConverter extends StatefulWidget {
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _units = ['meters', 'feet', 'kilograms', 'pounds'];

  String _fromUnit = 'meters';
  String _toUnit = 'feet';
  String _result = '';

  double convert(double value, String from, String to) {
    if (from == 'meters' && to == 'feet') return value * 3.28084;
    if (from == 'feet' && to == 'meters') return value / 3.28084;
    if (from == 'kilograms' && to == 'pounds') return value * 2.20462;
    if (from == 'pounds' && to == 'kilograms') return value / 2.20462;
    return value;
  }

  void _handleConversion() {
    final input = double.tryParse(_controller.text);
    if (input != null) {
      final converted = convert(input, _fromUnit, _toUnit);
      setState(() {
        _result =
            '$input $_fromUnit are ${converted.toStringAsFixed(3)} $_toUnit';
      });
    } else {
      setState(() {
        _result = 'Invalid input';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Measures Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Value', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter value',
              ),
            ),
            SizedBox(height: 20),
            Text('From', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _fromUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _fromUnit = newValue!;
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('To', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _toUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _toUnit = newValue!;
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _handleConversion,
                child: Text('Convert'),
              ),
            ),
            SizedBox(height: 20),
            Center(child: Text(_result, style: TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }
}
