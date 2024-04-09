<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A flutter package for both Android and iOS which provides the validation functionalities for the input fields.

## Features

Provides validation for the input types 
    1. text
    2. password
    3. email
    4. phone
    5. url

## Getting started

Add the ```text_field_validator``` package into pubspec.yaml file start working.
import the package as ```import 'package:text_field_validator/text_field_validator.dart';```

## Usage

```import 'package:flutter/material.dart';
import 'package:text_field_validator/text_field_validator.dart';

class ValidatorTest extends StatefulWidget {
    const ValidatorTest({Key? key}) : super(key: key);

    @override
    State<ValidatorTest> createState() => _ValidatorTestState();
}

class _ValidatorTestState extends State<ValidatorTest> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(),
            body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                    child: Column(
                        children: [
                            TextFormField(
                                validator: (value) {
                                    return TextFieldValidator.textValidator(
                                        value: value,
                                    );
                                },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                                validator: (value) {
                                    return TextFieldValidator.passWordValidator(
                                        password: value,
                                    );
                                },
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
```

