import 'package:flutter/material.dart';

import '../../../core/widgets/app_sizer.dart';

class UserDetailWidget extends StatelessWidget {
  final String image;
  final String name;
  final String score;
  final String license;
  final String reputation;
  final String lastActDate;
  final String createDate;
  final IconData icon;
  final void Function() onTap;
  final void Function() onTapDelete;

  const UserDetailWidget({
    super.key,
    required this.image,
    required this.name,
    required this.score,
    required this.license,
    required this.reputation,
    required this.lastActDate,
    required this.createDate,
    required this.icon,
    required this.onTap,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                width: MediaQuery.of(context).size.width,
                height: 200,
                image,
                fit: BoxFit.cover,
              )),
          const HeightBox(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
              Text(
                score,
                style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
              ),
            ],
          ),
          const HeightBox(3),
          Text(
            license,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          const HeightBox(3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  reputation,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ),
              InkWell(
                onTap: () {
                  onTap();
                },
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const HeightBox(3),
          Text(
            lastActDate,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          const HeightBox(3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  createDate,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ),
              InkWell(
                onTap: () {
                  onTapDelete();
                },
                child: const Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const HeightBox(3),
        ],
      ),
    );
  }
}
