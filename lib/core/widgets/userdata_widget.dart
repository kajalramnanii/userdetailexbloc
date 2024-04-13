import 'package:flutter/material.dart';

import 'app_sizer.dart';

class UserDataWidget extends StatelessWidget {
  final ImageProvider image;
  final String name;
  final String createDate;
  final String lastActivityDate;
  final void Function() onTap;
  final IconData icon;
  const UserDataWidget(
      {super.key,
      required this.image,
      required this.name,
      required this.createDate,
      required this.lastActivityDate,
      required this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: image,
            backgroundColor: Colors.transparent,
          ),
          const WidthBox(12),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
              Text(
                'Create Date : $createDate',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              Text(
                'Last Activity Date : $lastActivityDate',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => onTap(),
            child: Icon(
              icon,
              size: 20,
              color: Colors.red,
            ),
          ),
          const WidthBox(12),
        ],
      ),
    );
  }
}
