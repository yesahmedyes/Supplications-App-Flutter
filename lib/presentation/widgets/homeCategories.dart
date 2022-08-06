import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplications_app/logic/categories/categories_bloc.dart';
import 'package:supplications_app/logic/supplications/supplications_bloc.dart';
import 'package:supplications_app/presentation/screens/supplicationsListScreen.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesInitialState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CategoriesFetchedState) {
          state.categories.sort(((a, b) => a.index.compareTo(b.index)));

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
            itemCount: state.categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            itemBuilder: (context, index) {
              return Card(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.grey, width: 0.2),
                ),
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    context.read<SupplicationsBloc>().add(SupplicationsOpenEvent(categoryId: state.categories[index].categoryId));
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (BuildContext context) => SupplicationsListScreen(category: state.categories[index].name)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CachedNetworkImage(
                          imageUrl: state.categories[index].image,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          width: 60,
                        ),
                        Text(
                          state.categories[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Color(0xFF484848), fontSize: 14, fontWeight: FontWeight.w500, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: Text('Please check your internet connection and try again later.'));
      },
    );
  }
}
