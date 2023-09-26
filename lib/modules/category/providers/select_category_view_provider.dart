import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/category/models/categories_response_model.dart';
import 'package:sip_app/modules/category/repositories/category_repository.dart';

class SelectCategoryPair {
  final int mainCategoryId;
  final Map<int, int> middleCategoryIds;

  SelectCategoryPair(
      {required this.mainCategoryId, required this.middleCategoryIds});

  SelectCategoryPair copyWith(
      {int? mainCategoryId, Map<int, int>? middleCategoryIds}) {
    print('copywidth');
    return SelectCategoryPair(
        mainCategoryId: mainCategoryId ?? this.mainCategoryId,
        middleCategoryIds: middleCategoryIds ?? this.middleCategoryIds);
  }
}

final mainCategoryListProvider = StateNotifierProvider<
    MainCategoryStateNotifier, MainCategoriesResponseModel>((ref) {
  final Dio dio = Dio();
  final CategoryRepository repository = CategoryRepository(dio,
      baseUrl: '$SERVER_BASE_URL/users/categories');

  final notifier = MainCategoryStateNotifier(repository: repository);
  return notifier;
});

final middleCategoryListProvider = StateNotifierProvider.family<
    MiddleCategoryStateNotifier,
    CategoriesResponseBase,
    int>((ref, categoryId) {
  final Dio dio = Dio();
  final CategoryRepository repository = CategoryRepository(dio,
      baseUrl: '$SERVER_BASE_URL/users/categories/');
  final notifier = MiddleCategoryStateNotifier(
      repository: repository, categoryId: categoryId);
  return notifier;
});

class MiddleCategoryStateNotifier
    extends StateNotifier<CategoriesResponseBase> {
  final CategoryRepository repository;
  final int categoryId;

  MiddleCategoryStateNotifier(
      {required this.repository, required this.categoryId})
      : super(MiddleCategoriesResposeLoading()) {
    paginate();
  }

  Future<void> paginate() async {
    if (categoryId == 0) {
      return;
    }

    try {
      final res = await repository.getMiddleCategories(id: categoryId);
      final middleCategories = res.response;

      final pState =
          MiddleCategoriesResponseModel(middleCategories: middleCategories);

      state = pState;
    } catch (error) {
      state = MiddleCategoriesResponseError();
    }
  }
}

class MainCategoryStateNotifier
    extends StateNotifier<MainCategoriesResponseModel> {
  final CategoryRepository repository;

  MainCategoryStateNotifier({
    required this.repository,
  }) : super(MainCategoriesResponseModel(mainCategories: []));

  Future<MainCategoriesResponseModel?> initialize() async {
    if (state.mainCategories.isEmpty) {
      try {
        final res = await repository.getCategories();
        state = state.copyWith(mainCategories: res.response.mainCategories);

        return state;
      } catch (error) {
        print(error);
        return null;
      }
    } else {
      return state;
    }
  }
}

final selectCategoryPairProvider =
    StateNotifierProvider.family<SelectedCategoryPairNotifier, SelectCategoryPair, String>(
        (ref, type) {
  final notifier = SelectedCategoryPairNotifier();

  return notifier;
});

class SelectedCategoryPairNotifier extends StateNotifier<SelectCategoryPair> {
  SelectedCategoryPairNotifier()
      : super(SelectCategoryPair(mainCategoryId: 0, middleCategoryIds: {}));

  void selectedMainCategory(int id) {
    if (id == 0) {
      return;
    }

    state = state.copyWith(
      mainCategoryId: id,
    );
  }

  void selectMiddleCategory(int middleCategoryId, bool isSelected) {
    if (middleCategoryId == 0) {
      return;
    }
    final int mainCategoryId = state.mainCategoryId;

    if (mainCategoryId == 0) {
      return;
    }

    if (isSelected) {
      Map<int, int> newMiddleCategoryIds = Map.from(state.middleCategoryIds);
      newMiddleCategoryIds.remove(mainCategoryId);
      state = state.copyWith(middleCategoryIds: {});
    } else {
      // 미들카테고리 아이디 추가
      Map<int, int> newMiddleCategoryIds = Map.from(state.middleCategoryIds);
      newMiddleCategoryIds.addAll({mainCategoryId: middleCategoryId});

      state = state.copyWith(middleCategoryIds: newMiddleCategoryIds);
    }
  }
}
