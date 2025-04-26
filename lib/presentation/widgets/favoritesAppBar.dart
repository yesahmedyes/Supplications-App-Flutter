import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplications_app/logic/supplications/supplications_bloc.dart';

class FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoritesAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 22),
        onPressed: () {
          context.read<SupplicationsBloc>().add(SupplicationsCloseEvent());
          Navigator.of(context).pop();
        },
      ),
      title: const Text('Favorites', style: TextStyle(fontSize: 17)),
      centerTitle: false,
      titleSpacing: 4,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
