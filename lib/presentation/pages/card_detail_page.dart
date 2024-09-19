import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/presentation/providers/providers.dart';

class CardDetailPage extends ConsumerStatefulWidget {
  static const name = 'card-detail-page';
  static const path = name;

  final String cardId;

  const CardDetailPage({super.key, required this.cardId});

  @override
  CardDetailScreenState createState() => CardDetailScreenState();
}

class CardDetailScreenState extends ConsumerState<CardDetailPage> {
  @override
  void initState() {
    super.initState();

    ref.read(cardInfoProvider.notifier).loadCard(widget.cardId);
  }

  @override
  Widget build(BuildContext context) {
    final YuGiOhCard? card =
        ref.watch(cardInfoProvider)[widget.cardId.toString()];

    if (card == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(card: card),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _CardDetails(card: card),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _CardDetails extends StatelessWidget {
  final YuGiOhCard card;

  const _CardDetails({required this.card});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (card.cardImages?.isNotEmpty == true)
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    card.cardImages![0].imageUrl!,
                    width: size.width * 0.3,
                  ),
                ),

              const SizedBox(width: 10),

              // Description
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(card.name ?? '', style: textStyles.titleLarge),
                    Text(card.desc ?? '', style: textStyles.bodySmall),
                  ],
                ),
              )
            ],
          ),
        ),

        // // Generos de la película
        // Padding(
        //   padding: const EdgeInsets.all(8),
        //   child: Wrap(
        //     children: [
        //       ...card.genreIds.map((gender) => Container(
        //             margin: const EdgeInsets.only(right: 10),
        //             child: Chip(
        //               label: Text(gender),
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(20)),
        //             ),
        //           ))
        //     ],
        //   ),
        // ),

        const SizedBox(height: 50),
      ],
    );
  }
}

class _CustomSliverAppBar extends ConsumerWidget {
  final YuGiOhCard card;

  const _CustomSliverAppBar({required this.card});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
            if (card.cardImages?.isNotEmpty == true)
              SizedBox.expand(
                child: Image.network(
                  card.cardImages?[0].imageUrlCropped ?? '',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) return const SizedBox();
                    return FadeIn(child: child);
                  },
                ),
              ),
            const _CustomGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.0,
                  0.2
                ],
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ]),
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.8, 1.0],
                colors: [Colors.transparent, Colors.black54]),
            const _CustomGradient(begin: Alignment.topLeft, stops: [
              0.0,
              0.3
            ], colors: [
              Colors.black87,
              Colors.transparent,
            ]),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.begin = Alignment.centerLeft,
      this.end = Alignment.centerRight,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, stops: stops, colors: colors))),
    );
  }
}
