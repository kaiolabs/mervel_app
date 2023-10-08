import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mervel_app/core/components/text_pattern.dart';
import 'package:skeletons/skeletons.dart';

class ImageLoader extends StatefulWidget {
  final String url;
  const ImageLoader({super.key, required this.url});

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => SkeletonItem(
        child: SkeletonLine(
          style: SkeletonLineStyle(
            height: 300,
            width: MediaQuery.of(context).size.width * 0.9,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(height: 8),
            TextPattern(
              text: 'Link inválido ou indisponível',
              color: Colors.red,
              textAlign: TextAlign.center,
              fontSize: 14,
            ).bold(),
          ],
        ),
      ),
    );
  }
}
