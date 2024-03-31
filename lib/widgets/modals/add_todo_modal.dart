import 'package:flutter/material.dart';

class AddToDoModal extends StatelessWidget {
  const AddToDoModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var value = '';

    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            onChanged: (val) {
              value = val;
            },
            decoration: const InputDecoration(
              labelText: 'To do title',
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(
              context,
              value,
            ),
            child: const Text('add to do'),
          ),
        ],
      ),
    );
  }
}
