import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qra/constants.dart';

class FilterView extends HookWidget {
  const FilterView(
      {Key? key,
      required this.allFunction,
      required this.todayFunction,
      required this.tomorrowFunction})
      : super(key: key);
  final VoidCallback allFunction;
  final VoidCallback todayFunction;
  final VoidCallback tomorrowFunction;
  @override
  Widget build(BuildContext context) {
    //todo: Use The static access when you choose the all, tomorrow amd today with dateTime
    var items = ['All', 'Today', 'Tomorrow'];
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 20),
            child: const Text(
              "Sort by",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: items[index] == "All"
                      ? allFunction
                      : items[index] == "Today"
                          ? todayFunction
                          : tomorrowFunction,
                  title: Text(
                    items[index],
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
