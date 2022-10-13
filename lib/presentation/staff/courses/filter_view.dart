import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qra/constants.dart';

class FilterView extends HookConsumerWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ['All', 'Today\'s date', 'Custom date'];
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Constants.coolBlue,
        borderRadius: const BorderRadius.only(
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
                  onTap: () async {
                    // if (items[index] == context.resources.strings.all){
                    //   await ref.read(AppOrderViewModel.provider.notifier).getOrders();
                    //   Get.back();
                    // }
                    // else if (items[index] == context.resources.strings.pendingPickUp){
                    //   ref.read(AppOrderViewModel.provider.notifier).getOrdersByStatus('PENDING_PICKUP');
                    //   // ref.read(AppOrderViewModel.Provider).updateData();
                    //   // Get.back();
                    // }
                    // else if (items[index] == context.resources.strings.pendingDelivery){
                    //   ref.read(AppOrderViewModel.provider.notifier).getOrdersByStatus('PENDING_DELIVERY');
                    // }
                  },
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
