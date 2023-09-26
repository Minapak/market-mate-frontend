import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/category/widgets/middle_category_hashtag_view.dart';

// class ExpertListView extends ConsumerWidget {
//   final int index;
//   final
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ExpertItem(expert: expert)
//   }
// }

// class ExpertListView extends ConsumerStatefulWidget {
//   final ExpertsPaginationParams param = ExpertsPaginationParams();

//   @override
//   ExpertListViewState createState() => ExpertListViewState();
// }

// class ExpertListViewState extends ConsumerState<ExpertListView> {
//   bool isLoading = true;
//   Timer? timer = null;

//   @override
//   void initState() {
//     super.initState();
//     timer = Timer(const Duration(milliseconds: 2000), () {
//       setState(() {
//         isLoading = false;
//       });
//     });

//     fetch();
//   }

//   void fetch() async {
//     final provider =
//         ref.read(ExpertsProviderFamily(widget.param).notifier).paginate();
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final config = ref.watch(ExpertsProviderFamily(widget.param));
//     if (config.response.content.length > 0) {
//       print(config.content[0].expertName);
//     }

//     return isLoading
//         ? Padding(
//             padding: EdgeInsets.only(bottom: 20),
//             child: ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: 5,
//               itemBuilder: (context, index) => Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: Container(
//                   height: 130,
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: SkeletonItem(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 0,
//                           child: SkeletonAvatar(
//                             style: SkeletonAvatarStyle(
//                                 shape: BoxShape.circle, width: 60, height: 60),
//                           ),
//                         ),
//                         SizedBox(width: 16),
//                         Expanded(
//                             flex: 1,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SkeletonParagraph(
//                                   style: SkeletonParagraphStyle(
//                                       padding: EdgeInsets.all(0),
//                                       lines: 2,
//                                       spacing: 4,
//                                       lineStyle: SkeletonLineStyle(
//                                         randomLength: true,
//                                         height: 15,
//                                         borderRadius: BorderRadius.circular(4),
//                                         minLength:
//                                             MediaQuery.of(context).size.width /
//                                                 6,
//                                         maxLength:
//                                             MediaQuery.of(context).size.width /
//                                                 3,
//                                       )),
//                                 ),
//                                 SizedBox(height: 8),
//                                 SkeletonParagraph(
//                                   style: SkeletonParagraphStyle(
//                                       padding: EdgeInsets.all(0),
//                                       lines: 1,
//                                       spacing: 4,
//                                       lineStyle: SkeletonLineStyle(
//                                         randomLength: true,
//                                         height: 15,
//                                         borderRadius: BorderRadius.circular(4),
//                                         minLength:
//                                             MediaQuery.of(context).size.width /
//                                                 3,
//                                         maxLength:
//                                             MediaQuery.of(context).size.width /
//                                                 1,
//                                       )),
//                                 ),
//                                 SizedBox(height: 8),
//                                 SkeletonParagraph(
//                                   style: SkeletonParagraphStyle(
//                                       padding: EdgeInsets.all(0),
//                                       lines: 1,
//                                       spacing: 4,
//                                       lineStyle: SkeletonLineStyle(
//                                         randomLength: true,
//                                         height: 15,
//                                         borderRadius: BorderRadius.circular(4),
//                                         minLength:
//                                             MediaQuery.of(context).size.width /
//                                                 3,
//                                         maxLength:
//                                             MediaQuery.of(context).size.width /
//                                                 1,
//                                       )),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ))
//         : Expanded(
//             child: ListView.separated(
//             itemCount: config.response.content.length,
//             itemBuilder: (_, index) {
//               if (index == config.response.content.length) {
//                 return Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16.0, vertical: 8.0),
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ));
//               }

//               final pItem = config.response.content[index];

//               return ExpertItem(expert: pItem);
//             },
//             separatorBuilder: (_, index) {
//               return SizedBox(height: 1.0);
//             },
//           ));
//   }
// }
// Container(
//         padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
//         child: Skeleton(
//           isLoading: true,
//           skeleton: SkeletonListView(),
//           child: Column(
//               children:
//                   experts.map((expert) => ExpertItem(expert: expert)).toList()),
//         ));

class ExpertItem extends StatelessWidget {
  final ExpertModel expert;

  const ExpertItem({required this.expert, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final int id = expert.id;
          final String name = expert.name;
          context.push('/experts/detail/$id?name=$name');
        },
        child: Container(
            padding: EdgeInsets.all(16),
            // margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: NetworkImage(expert.thumbnail ?? ''),
                              fit: BoxFit.cover)),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${expert.name} 전문가',
                                  style: TextStyle(
                                      color: FIXED_WIDGET_BACKGROUNG_COLOR,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(
                                height: 4,
                              ),
                              Text('${expert.marketName}',
                                  style: TextStyle(
                                      color: COMMUNITY_CATEGORY_COLOR,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 4,
                              ),
                              Text('${expert.content}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: GRAY_COLOR_FONT,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 2,
                              ),
                              Wrap(
                                children: expert.middleCategories!
                                    .map((item) =>
                                        HashtagItemView(name: item.name))
                                    .toList(),
                              )
                            ],
                          ),
                        ))
                  ]),
            )));
  }
}
