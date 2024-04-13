import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdetailexbloc/core/extensions/app_extension.dart';
import 'package:userdetailexbloc/src/detail/widget/userdetail_widget.dart';
import 'package:userdetailexbloc/src/home/bloc/home_bloc.dart';
import 'package:userdetailexbloc/src/home/models/user_model.dart';

class DetailPage extends StatelessWidget {
  final UserModel model;
  final int index;
  const DetailPage({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    final item = model.items![index];
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.blueGrey,
          ),
        ),
        title: Text(
          item.owner!.displayName!.toUpperCase(),
          style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return UserDetailWidget(
            image: item.owner!.profileImage ?? "",
            name: "Name : ${item.owner!.displayName ?? ""}",
            score: "Score : ${item.score ?? ""}",
            license: 'Content License : ${item.contentLicense ?? ""} ',
            reputation: "reputation : ${item.owner!.reputation ?? ""}",
            lastActDate:
                'Last Activity Date : ${DateTime.fromMillisecondsSinceEpoch(int.parse(item.lastActivityDate.toString()) * 1000).toCustomFormattedString()} ',
            createDate:
                'Creation Date : ${DateTime.fromMillisecondsSinceEpoch(int.parse(item.creationDate.toString()) * 1000).toCustomFormattedString()}',
            icon: item.isFav ? Icons.favorite : Icons.favorite_border,
            onTap: () {
              context.read<HomeBloc>().add(
                    HomeChangeFav(index: index, model: model),
                  );
            },
            onTapDelete: () {
              model.items!.removeAt(index);
              context
                  .read<HomeBloc>()
                  .add(HomeDeleteEvent(index: index, model: model));

              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
