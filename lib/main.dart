import 'package:flutter/material.dart';
import 'package:widget_test/fibo.dart';

const double tileHeight = 50;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FibonacciListScreen(),
    );
  }
}

class FibonacciListScreen extends StatefulWidget {
  const FibonacciListScreen({super.key});

  @override
  State<FibonacciListScreen> createState() => _FibonacciListScreenState();
}

class _FibonacciListScreenState extends State<FibonacciListScreen> {
  Finonaccis fibonaccis = Finonaccis();
  List<FinonacciNumber> removedNumbers = [];
  int? highlightedIndex;
  final scrollController = ScrollController();
  final buttomSheetScrollController = ScrollController();

  void _onNumberTap(int removeIndex, FinonacciNumber tappedNumber) {
    // 3. Tap Functionality
    setState(() {
      highlightedIndex = null;
    });
    removedNumbers.add(fibonaccis.fiboNumbers.removeAt(removeIndex));
    // sort removed numbers by index
    removedNumbers.sort((a, b) => a.index.compareTo(b.index));

    int tappedType = tappedNumber.type;
    // 3.1 Display a BottomSheet containing a list of items, filtered to show only items with the same type as the tapped Fibonacci number.
    List<FinonacciNumber> filteredRemoved =
        removedNumbers.where((element) => element.type == tappedType).toList();

    if (filteredRemoved.isEmpty) return;

    //get the index of the tapped number after filter
    int tappedIndex = filteredRemoved
        .indexWhere((element) => element.number == tappedNumber.number);

    Future.delayed(Duration(milliseconds: 300), () {
      buttomSheetScrollController.animateTo(
          (tappedIndex * (tileHeight + 20)).clamp(
              buttomSheetScrollController.position.minScrollExtent,
              buttomSheetScrollController.position.maxScrollExtent),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut);
    });

    showModalBottomSheet(
      // isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => ListView.builder(
        controller: buttomSheetScrollController,
        itemCount: filteredRemoved.length,
        itemBuilder: (context, index) {
          final item = filteredRemoved[index];
          return InkWell(
            // 3.2 Each item in the BottomSheet should be tappable
            onTap: () {
              // 3.3 When tapping an item
              setState(() {
                // 3.3.1 Remove the item from the BottomSheet and add it back to the main list
                removedNumbers.remove(item);
                fibonaccis.fiboNumbers.insert(item.index, item);
                // 3.3.3 Highlight the item that was just added back in the main list
                highlightedIndex = item.index;
              });
              // 3.3.2 Close the BottomSheet
              Navigator.pop(context);

              // 3.3.4 Scroll to the Highlight item
              Future.delayed(Duration(milliseconds: 300), () {
                scrollController.animateTo(
                  item.index * tileHeight,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              alignment: Alignment.center,
              color: item.number == tappedNumber.number
                  ? Colors.green[200]
                  : Colors.transparent,
              height: tileHeight + 20,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Number: ${item.number}'),
                      Text(
                        'Index: ${item.index}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const Spacer(),
                  Icon(item.getTypeIcon()),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          );
        },
      ),
    ).then((v) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        const Text(
          "Example",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        const SizedBox(height: 10),
        // 1. Scrollable Widget
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: fibonaccis.fiboNumbers.length,
            itemBuilder: (context, i) {
              final number = fibonaccis.fiboNumbers[i];
              final isHighlighted = i == highlightedIndex;

              return InkWell(
                onTap: () {
                  _onNumberTap(i, number);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  alignment: Alignment.center,
                  color: isHighlighted ? Colors.red[200] : Colors.white,
                  height: tileHeight,
                  child: Row(
                    // 2. Display Widget
                    children: [
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 75,
                        child: Text("Index: ${number.index},"),
                      ),
                      Text("Number: ${number.number}"),
                      const Spacer(),
                      Icon(number.getTypeIcon()),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    )));
  }
}
