import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplications_app/data/models/supplication.dart';
import 'package:supplications_app/logic/favorites/favorites_bloc.dart';

class SupplicationsFavoriteButton extends StatefulWidget {
  const SupplicationsFavoriteButton({Key? key, required this.supplication}) : super(key: key);

  final Supplication supplication;

  @override
  State<SupplicationsFavoriteButton> createState() => _SupplicationsFavoriteButtonState();
}

class _SupplicationsFavoriteButtonState extends State<SupplicationsFavoriteButton> {
  @override
  void initState() {
    super.initState();
  }

  _toggleFavorite() {
    context.read<FavoritesBloc>().add(FavoritesToggleEvent(categoryId: widget.supplication.categoryId, supplicationId: widget.supplication.supplicationId));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleFavorite,
      child: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          bool isFavorite = false;

          if (state is FavoritesLoadedState && state.favorites.contains(widget.supplication.categoryId + ' ' + widget.supplication.supplicationId)) {
            isFavorite = true;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: const Color.fromRGBO(110, 110, 110, 1),
              size: 25,
            ),
          );
        },
      ),
    );
  }
}
