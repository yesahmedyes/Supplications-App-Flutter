import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplications_app/data/models/supplication.dart';
import 'package:supplications_app/logic/audio/audio_bloc.dart';
import 'package:supplications_app/logic/supplications/supplications_bloc.dart';
import 'package:supplications_app/presentation/widgets/favoritesAppBar.dart';
import 'package:supplications_app/presentation/widgets/justAudioWidget.dart';
import 'package:supplications_app/presentation/widgets/supplicationsCard.dart';

class FavoriteSupplicationsScreen extends StatelessWidget {
  const FavoriteSupplicationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2f2f2),
      appBar: const FavoritesAppBar(),
      body: BlocBuilder<SupplicationsBloc, SupplicationsState>(
        builder: (context, state) {
          if (state is SupplicationsLoadedState) {
            if (state.supplications.isEmpty) {
              return const Center(child: Text('Nothing availaible in favorites yet.'));
            }

            final List<Supplication> _supplications = state.supplications;
            _supplications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

            return ListView.builder(
              itemCount: _supplications.length + 2,
              itemBuilder: (context, index) {
                if (index == 0 || index == _supplications.length + 1) {
                  return const SizedBox(height: 20);
                }
                return BlocBuilder<AudioBloc, AudioState>(
                  builder: (context, state) {
                    String? url;

                    if (state is AudioStartedState) {
                      url = state.url;
                    }

                    return SupplicationCard(supplication: _supplications[index - 1], playing: (url == _supplications[index - 1].audio));
                  },
                );
              },
            );
          }
          if (state is SupplicationsFailedState) {
            return const Center(child: Text('Please check your internet connection and try again later.'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BlocBuilder<AudioBloc, AudioState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              boxShadow: const [
                BoxShadow(offset: Offset(0, -1), color: Colors.black26, blurRadius: 5),
              ],
            ),
            height: (state is AudioStartedState) ? 300 : 0,
            child: (state is AudioStartedState) ? JustAudioWidget(url: state.url) : const JustAudioWidget(url: ""),
          );
        },
      ),
    );
  }
}
