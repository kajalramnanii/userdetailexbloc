import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdetailexbloc/core/extensions/app_extension.dart';
import 'package:userdetailexbloc/src/home/bloc/home_bloc.dart';

import '../../core/widgets/userdata_widget.dart';

class FavPage extends StatelessWidget {
  const FavPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // print("fav length --> ${items.length}");
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
        title: const Text(
          "Favourite Data",
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            // TODO: Handle this case.
            HomeSuccess() => ListView.builder(
                itemCount: state.model.items!
                    .where((element) => element.isFav)
                    .toList()
                    .length,
                itemBuilder: (context, index) {
                  final items = state.model.items!
                      .where((element) => element.isFav)
                      .toList()[index];
                  return UserDataWidget(
                    image: NetworkImage(items.owner!.profileImage ?? ""),
                    name: items.owner!.displayName ?? '',
                    createDate: DateTime.fromMillisecondsSinceEpoch(
                            int.parse(items.creationDate.toString()) * 1000)
                        .toCustomFormattedString(),
                    lastActivityDate: DateTime.fromMillisecondsSinceEpoch(
                            int.parse(items.lastActivityDate.toString()) * 1000)
                        .toCustomFormattedString(),
                    onTap: () {},
                    icon: items.isFav ? Icons.favorite : Icons.favorite_border,
                  );
                },
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
