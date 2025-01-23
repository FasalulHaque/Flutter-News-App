import 'package:intl/intl.dart';

import '../../../../core/utils/imports.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String month = DateFormat.MMMM().format(now);
    String dayNumber = DateFormat.d().format(now);
    String dayName = DateFormat.EEEE().format(now);

    String formattedDate = "$month $dayNumber, $dayName";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Today',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshNews,
        child: Column(
          children: [
            NewsSearchBar(
              onSearch: controller.searchNews,
            ),
            Expanded(
              child: ListView(
                controller: controller.scrollController,
                children: [
                  Obx(() => controller.searchQuery.isEmpty
                      ? const TopHeadlinesSection()
                      : const SizedBox.shrink()),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Obx(() => Text(
                          controller.searchQuery.isEmpty
                              ? 'All News'
                              : 'Search Results',
                          style: GoogleFonts.acme(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  Obx(() {
                    if (controller.hasErrorAllNews.value) {
                      return ErrorView(
                        message: controller.errorMessageAllNews.value,
                        onRetry: controller.refreshNews,
                      );
                    }

                    if (controller.noSearchResults.value) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off,
                              size: 48,
                              color: Colors.grey,
                            ),
                            SizedBox(
                                height: ResponsiveHelper.screenHeight(context) *
                                    0.01),
                            Text(
                              'No results found for "${controller.searchQuery.value}"',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: [
                        ...controller.allNews.map((article) => ArticleCard(
                              article: article,
                            )),
                        if (controller.hasReachedMaxAllNews.value)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                'No more articles available',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        else if (controller.isLoadingAllNews.value)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
