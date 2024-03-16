import 'package:flutter/material.dart';

class AddToDoModal extends StatelessWidget {
  const AddToDoModal({
    super.key,
    required this.addItem,
    required this.textEditingController,
  });

  final void Function() addItem;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textEditingController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'To do title',
            ),
          ),
          ElevatedButton(
            onPressed: addItem,
            child: const Text('Add to do'),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
        ],
      ),
    );
  }
}
