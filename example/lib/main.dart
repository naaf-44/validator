import 'package:flutter/material.dart';
import 'package:text_field_validator/text_field_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Field Validator Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Validator Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  return TextFieldValidator.textValidator(
                    value: value,
                    minLength: 2,
                    maxLength: 5,
                  );
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  return TextFieldValidator.passWordValidator(
                    password: value,
                    minPasswordLength: 8,
                  );
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                validator: (value) {
                  return TextFieldValidator.urlValidator(
                    url: value,
                  );
                },
                keyboardType: TextInputType.url,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
