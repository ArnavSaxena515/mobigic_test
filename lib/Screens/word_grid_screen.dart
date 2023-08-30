// This is the grid screen

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic_test/Screens/grid_input_screen.dart';
import 'package:mobigic_test/utils.dart';

class WordGridScreen extends StatefulWidget {
  static const routeName = "/word-grid-screen";
  final Map<String, int> dimensions;

  const WordGridScreen({Key? key, required this.dimensions}) : super(key: key);

  @override
  State<WordGridScreen> createState() => _WordGridScreenState();
}

class _WordGridScreenState extends State<WordGridScreen> {
  // defining properties
  late int numberOfRows;
  late int numberOfColumns;
  late List<List<String>> gridData;
  late List<List<Color>> cellColors;
  String wordToSearch = "";
  bool gridLocked = false;
  int gridCount = 0;

// to reset the colours inside the grid
  void resetColors() {
    cellColors = List.generate(
        numberOfRows, (_) => List.filled(numberOfColumns, Colors.white));
  }

// method to reset the contents of the grid
  void resetGrid() {
    gridData =
        List.generate(numberOfRows, (_) => List.filled(numberOfColumns, ''));
    resetColors();
  }

// method to search for the given word and highlight the cells
  // different colours have been chosen to highlight words found vertically, horizontally or in the south-east diagonal
  void wordSearch(
      {required String word,
      required List<List<String>> gridData,
      required int numberOfRows,
      required int numberOfCols}) {
    setState(() {
      gridLocked = true;
    });
    word = word.toLowerCase();

    // search in rows
    for (int row = 0; row < gridData.length; row++) {
      for (int col = 0; col <= gridData[row].length - word.length; col++) {
        if (gridData[row]
                .sublist(col, col + word.length)
                .join()
                .toLowerCase() ==
            word) {
          for (int i = 0; i < word.length; i++) {
            cellColors[row][col + i] = Colors.green;
          }
        }
      }
    }

    // search in columns
    for (int col = 0; col < gridData[0].length; col++) {
      for (int row = 0; row <= gridData.length - word.length; row++) {
        // columnSubstring is used to store all the letters found in a particular column by iterating over the rows inside the column
        List<String> columnSubstring = [];
        for (int i = 0; i < word.length; i++) {
          columnSubstring.add(gridData[row + i][col]);
        }
        // if word is found by joining the elements in the column substring, the corresponding cells are highlighted
        if (columnSubstring.join().toLowerCase() == word) {
          for (int i = 0; i < word.length; i++) {
            cellColors[row + i][col] = Colors.redAccent;
          }
        }
      }
    }

    // search in south-east diagonal
    for (int row = 0; row <= gridData.length - word.length; row++) {
      for (int col = 0; col <= gridData[row].length - word.length; col++) {
        // diagonalSubstring stores all letters found by traversing the diagonal in the southeast (row+i, col+i)
        List<String> diagonalSubstring = [];
        for (int i = 0; i < word.length; i++) {
          diagonalSubstring.add(gridData[row + i][col + i]);
        }
        if (diagonalSubstring.join().toLowerCase() == word) {
          for (int i = 0; i < word.length; i++) {
            cellColors[row + i][col + i] = Colors.blue;
          }
        }
      }
    }
    setState(() {});
  }

  void searchTheWord() {
    resetColors();
    // validate if the grid is populated
    if (gridCount < numberOfRows * numberOfColumns - 1) {
      showSnackBar(context, "Please fill the grid first");
      return;
    }

    wordSearch(
        word: wordToSearch,
        gridData: gridData,
        numberOfRows: numberOfRows,
        numberOfCols: numberOfColumns);
  }

  @override
  void initState() {
    numberOfColumns = widget.dimensions['columns']!;
    numberOfRows = widget.dimensions['rows']!;

    resetGrid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(GridInputScreen.routeName);
        },
        child: const Icon(Icons.restart_alt_outlined),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Fill in the grid",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numberOfColumns, // n columns
                ),
                itemCount: numberOfRows * numberOfColumns, // m rows
                itemBuilder: (context, index) {
                  // Calculate the row index and column index
                  final rowIndex = index ~/ numberOfColumns;
                  final colIndex = index % numberOfColumns;

                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: cellColors[rowIndex][colIndex]),
                    child: Center(
                      child: TextField(
                        readOnly: gridLocked,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color:
                                cellColors[rowIndex][colIndex] != Colors.white
                                    ? Colors.white
                                    : Colors.black),
                        onChanged: (text) {
                          // if cell was empty and is now filled, increment the gridCount
                          if (gridData[rowIndex][colIndex].isEmpty &&
                              text.isNotEmpty) {
                            gridCount += 1;
                          } else if (gridData[rowIndex][colIndex].isNotEmpty &&
                              // if cell was filled but now is empty, decrement the gridCount
                              text.isEmpty) {
                            gridCount -= 1;
                          }
                          gridData[rowIndex][colIndex] =
                              text; // Update grid data
                        },
                        controller: TextEditingController(
                            text: gridData[rowIndex][colIndex]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onSubmitted: (text) {
                      wordToSearch = text;
                      searchTheWord();
                    },
                    decoration: const InputDecoration(
                      label: Text("🔍 Enter word to search in grid"),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                    onChanged: (text) => wordToSearch = text,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    searchTheWord();
                  },
                  child: const Text("Search"),
                  //leading: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
