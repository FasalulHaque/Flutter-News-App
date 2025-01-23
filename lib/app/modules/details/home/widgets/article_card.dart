import '../../../../core/utils/imports.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 237, 242, 252),
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.screenWidth(context) * 0.024,
          vertical: ResponsiveHelper.screenHeight(context) * 0.011),
      child: InkWell(
        onTap: () => Get.toNamed(Routes.details, arguments: article),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(4)),
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: NewsImagePlaceholder(
                    imageUrl: article.urlToImage,
                    width: double.infinity,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.005),
                  Text(
                    article.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.012),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.sourceName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        article.publishedAt,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
