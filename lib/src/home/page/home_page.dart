import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdetailexbloc/core/extensions/app_extension.dart';
import 'package:userdetailexbloc/core/widgets/app_sizer.dart';
import 'package:userdetailexbloc/core/widgets/userdata_widget.dart';
import 'package:userdetailexbloc/src/detail/detail_page.dart';
import 'package:userdetailexbloc/src/fav/fav_page.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.person,
          color: Colors.blueGrey,
        ),
        title: const Text(
          'User Details',
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavPage(),
                ),
              );
            },
            child: const Icon(
              Icons.favorite_outlined,
              color: Colors.blueGrey,
              size: 22,
            ),
          ),
          const WidthBox(18),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            HomeInitial() ||
            HomeLoading() =>
              const Center(child: CircularProgressIndicator()),
            HomeSuccess() => RefreshIndicator(
                onRefresh: () async =>
                    context.read<HomeBloc>().add(HomeAPICall()),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.model.items!.length,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        itemBuilder: (context, index) => Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            state.model.items!.removeAt(index);
                          },
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      model: state.model, index: index),
                                ),
                              );
                            },
                            child: UserDataWidget(
                              image: NetworkImage(state.model.items![index]
                                      .owner!.profileImage ??
                                  ""),
                              name: state
                                      .model.items![index].owner!.displayName ??
                                  '',
                              createDate: DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(state
                                              .model.items![index].creationDate
                                              .toString()) *
                                          1000)
                                  .toCustomFormattedString(),
                              lastActivityDate:
                                  DateTime.fromMillisecondsSinceEpoch(int.parse(
                                              state.model.items![index]
                                                  .lastActivityDate
                                                  .toString()) *
                                          1000)
                                      .toCustomFormattedString(),
                              onTap: () {
                                context.read<HomeBloc>().add(
                                      HomeChangeFav(
                                          index: index, model: state.model),
                                    );
                              },
                              icon: state.model.items![index].isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            HomeEmpty() => const Center(
                child: Text('No data found!!!'),
              ),
            _ => const SizedBox.shrink()
          };
        },
      ),
    );
  }
}
