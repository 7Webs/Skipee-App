import 'package:flutter/material.dart';

String URL = "https://squid-app-xxu6w.ondigitalocean.app";

void showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: const Color(0xFF1eb953)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: const Color(0xFF1eb953), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: color,
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white),
      ),
    ),
  );
}
