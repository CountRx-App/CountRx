import 'package:count_rx/models/pill_count.dart';
import 'package:flutter/material.dart';

class PillCountRow extends StatelessWidget {
  final PillCount pillCount;
  final void Function() onTapCallback;
  const PillCountRow(
      {super.key, required this.pillCount, required this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Card(
          child: ListTile(
            onTap: onTapCallback,
            leading: const Icon(Icons.movie),
            title: Text(
              pillCount.name.isEmpty
                  ? pillCount.timestamp.toString()
                  : pillCount.name,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: pillCount.name.isEmpty
                ? null
                : Text(
                    pillCount.timestamp.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }
}
