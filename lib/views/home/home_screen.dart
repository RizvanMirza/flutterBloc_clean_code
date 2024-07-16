import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_bloc_clean_coding/bloc/movies_bloc/movies_bloc.dart';
import 'package:youtube_bloc_clean_coding/config/components/internet_exception_widget.dart';
import 'package:youtube_bloc_clean_coding/config/rotues/routes_name.dart';
import 'package:youtube_bloc_clean_coding/main.dart';
import 'package:youtube_bloc_clean_coding/services/storage/local_storage.dart';

import '../../utils/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MoviesBloc moviesBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesBloc = MoviesBloc(moviesRepository: getIt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              LocalStorage localStorage = LocalStorage();
              localStorage.clearValue('token').then((value) {
                localStorage.clearValue('isLogin');
                Navigator.pushNamed(context, RoutesName.loginScreen);
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => moviesBloc..add(MoviesFetched()),
        child: BlocBuilder<MoviesBloc, MoviesStates>(
          builder: (context, state) {
            switch (state.moviesList.status) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                if (state.moviesList.message == 'No Internet Connection') {
                  return InternetExceptionWidget(
                    onPress: () => moviesBloc..add(MoviesFetched()),
                  );
                }
                return Center(
                  child: Text(state.moviesList.message.toString()),
                );
              case Status.completed:
                if (state.moviesList.data == null) {
                  return const Text("No Data Found");
                }
                final movieList = state.moviesList.data!;
                return ListView.builder(
                  itemCount: movieList.tvShows.length,
                  itemBuilder: (context, index) {
                    final tvShow = movieList.tvShows[index];
                    return Card(
                      child: ListTile(
                        leading: Image(
                          image: NetworkImage(
                            tvShow.imageThumbnailPath.toString(),
                          ),
                        ),
                        title: Text(
                          tvShow.name.toString(),
                        ),
                        subtitle: Text(
                          tvShow.network.toString(),
                        ),
                        trailing: Text(
                          tvShow.status.toString(),
                        ),
                      ),
                    );
                  },
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
