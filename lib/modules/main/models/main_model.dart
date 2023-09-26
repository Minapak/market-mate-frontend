import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';
import 'package:sip_app/modules/member/models/member_model.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/main/models/banner_model.dart';
import 'package:sip_app/modules/market/models/market_model.dart';

part 'main_model.g.dart';

@JsonSerializable()
class MainModel {
  final List<BannerModel> banners;
  final List<MainCategoryModel> mainCategories;
  final List<ExpertModel> powerExperts;
  final List<MarketModel> markets;
  //final List<MemberModel> members;

  MainModel(
      {required this.banners,
      required this.mainCategories,
      required this.powerExperts,
      required this.markets,
        //required this.members
      });

  factory MainModel.fromJson(Map<String, dynamic> json) =>
      _$MainModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainModelToJson(this);
}
