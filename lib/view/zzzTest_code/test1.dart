import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dropdown Text Field'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownTextField(),
          ),
        ),
      ),
    );
  }
}

class DropdownTextField extends StatefulWidget {
  @override
  _DropdownTextFieldState createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _options = [
    'Apple',
    'Banana',
    'Orange',
    'Grape',
    'Mango',
    'Apple',
    'Banana',
    'Orange',
    'Grape',
    'Mango',
    'Apple',
    'Banana',
    'Orange',
    'Grape',
    'Mango'
  ];
  String? _selectedValue;
  bool _isDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Focus(
          // Added Focus widget to handle focus changes
          onFocusChange: (hasFocus) {
            setState(() {
              _isDropdownVisible = hasFocus;
            });
          },
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Select an option',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.arrow_drop_down), // Icon inside TextField
            ),
            onChanged: (value) {
              setState(() {}); // Rebuild to filter dropdown
            },
            onTap: () {
              setState(() {
                _isDropdownVisible = true;
              });
            },
          ),
        ),
        if (_isDropdownVisible) // Conditionally show dropdown
          Card(
            // Added a Card for better visual separation
            elevation: 4,
            child: Container(
              constraints:
                  const BoxConstraints(maxHeight: 200), // Limit dropdown height
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _options
                    .where((option) => option
                        .toLowerCase()
                        .contains(_controller.text.toLowerCase()))
                    .length,
                itemBuilder: (context, index) {
                  final filteredOptions = _options
                      .where((option) => option
                          .toLowerCase()
                          .contains(_controller.text.toLowerCase()))
                      .toList();
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedValue = filteredOptions[index];
                        _controller.text = _selectedValue!;
                        _isDropdownVisible = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(filteredOptions[index]),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
