import '../../../../core/utils/imports.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => NewsRepository(apiProvider: Get.find<ApiProvider>()));
    Get.lazyPut(
        () => HomeController(newsRepository: Get.find<NewsRepository>()));
  }
}
