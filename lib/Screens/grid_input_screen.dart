// this screen takes input for the grid dimensions
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic_test/utils.dart';

import 'word_grid_screen.dart';

class GridInputScreen extends StatelessWidget {
  static const routeName = "/grid-input-screen";

  const GridInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String rows = "";
    String columns = "";
    void navigateToWordGridScreen(rows, columns) {
      // validating number of rows and columns entered
      if (int.parse(rows) <= 0 || int.parse(columns) <= 0) {
        showSnackBar(context, "Please enter values greater than 0");
        return;
      }
      Navigator.of(context).pushNamed(WordGridScreen.routeName,
          arguments: {"rows": int.parse(rows), "columns": int.parse(columns)});
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration:
                    const InputDecoration(label: Text("Number of Rows")),
                onChanged: (text) {
                  rows = text;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration:
                    const InputDecoration(label: Text("Number of Columns")),
                onChanged: (text) {
                  columns = text;
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  navigateToWordGridScreen(rows, columns);
                },
                child: const Text("Make the grid!"))
          ],
        ),
      ),
    );
  }
}
