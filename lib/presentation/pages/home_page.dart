import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yu_gi_oh_app/presentation/providers/providers.dart';
import 'package:yu_gi_oh_app/presentation/shared/custom_appbar.dart';
import 'package:yu_gi_oh_app/presentation/shared/full_screen_loader.dart';
import 'package:yu_gi_oh_app/presentation/widgets/card_masonry_item.dart';

/// main content of the App
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static const name = 'home-page';
  static const path = '/$name';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    /// the app will fetch the cards when the HomePage is initialized
    ref.read(allCardsProvider.notifier).fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    /// the app will show a loader while the cards are being fetched
    final initialLoading = ref.watch(initialLoadingProvider);

    /// the app will show the cards when they are fetched
    final cards = ref.watch(allCardsProvider);

    return Scaffold(
      body: (initialLoading)
          ? const FullScreenLoader()
          : CustomScrollView(slivers: [
              const SliverAppBar(
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: CustomAppbar(),
                  centerTitle: false,
                  titlePadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),

              /// the app will show the cards in a masonry grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverMasonryGrid.count(
                  /// limit count to 50, ideally, the api should have a pagination
                  /// to avoid fetching all the cards at once, so we can fetch more
                  /// cards when the user scrolls down
                  childCount: 50,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemBuilder: (BuildContext context, int index) {
                    debugPrint('index: $index');

                    /// the app will show a bigger card in the first position
                    if (index == 1) {
                      return Column(
                        children: [
                          const SizedBox(height: 40),
                          CardMasonryItem(card: cards[index])
                        ],
                      );
                    }

                    /// the app will show the rest of the cards
                    return CardMasonryItem(card: cards[index]);
                  },
                ),
              ),
            ]),
    );
  }
}
