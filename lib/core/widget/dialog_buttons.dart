import 'package:flutter/material.dart';

TextButton okButton<T>(BuildContext context, T? data) => TextButton(
      onPressed: () {
        Navigator.of(context).pop(data);
        print("pop data: $data");
      },
      child: const Text("OK"),
    );
TextButton cancelButton(BuildContext context) => TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("Cancel"),
    );
