import 'package:carousel_slider/carousel_slider.dart';
import 'package:cartzy/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({
    super.key,
  });

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  // final ValueNotifier<int>_selectedIndex=ValueNotifier(0);

  List topPicksArr = [
    {
      "name": "The Dissapearance of Emila Zola",
      "author": "Michael Rosen",
      "img": "assets/images/1.jpg"
    },
    {
      "name": "Fatherhood",
      "author": "Marcus Berkmann",
      "img": "assets/images/2.jpg"
    },
    {
      "name": "The Time Travellers Handbook",
      "author": "Stride Lottie",
      "img": "assets/images/3.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Column(
      children: [
        // CarouselSlider(
        //   options: CarouselOptions(height: 180,onPageChanged:(index,reason){
        //     _selectedIndex.value=index;
        //   }),
        //   items: [1,2,3,4,5].map((i) {
        //     return Builder(
        //       builder: (BuildContext context) {
        //         return Container(
        //             width: MediaQuery.of(context).size.width,
        //             margin: EdgeInsets.symmetric(horizontal: 5.0),
        //             decoration: BoxDecoration(
        //                 color: AppColors.themeColor
        //             ),
        //             alignment: Alignment.center,
        //             child: Text('text $i', style: TextStyle(fontSize: 16.0,),)
        //         );
        //       },
        //     );
        //   }).toList(),
        // ),

        SizedBox(
          width: media.width,
          height: media.width * 0.7,
          child: CarouselSlider.builder(
            itemCount: topPicksArr.length,
            itemBuilder: (BuildContext context, int itemIndex,
                int pageViewIndex) {
              var iObj = topPicksArr[itemIndex] as Map? ?? {};
              return TopPicksCell(
                iObj: iObj,
              );
            },
            options: CarouselOptions(
              autoPlay: false,
              aspectRatio: 1,
              enlargeCenterPage: true,
              viewportFraction: 0.45,
              enlargeFactor: 0.5,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            ),
          ),
        ),












        //
        // const SizedBox(height: 8),
        // ValueListenableBuilder(
        //   valueListenable: _selectedIndex,
        //   builder: (context,currentIndex,_) {
        //     return Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         for(int i=0;i<5;i++)
        //           Container(
        //             height: 12,
        //             width: 12,
        //             margin: EdgeInsets.only(right: 4),
        //             decoration: BoxDecoration(
        //                 color: _selectedIndex.value==i? AppColors.themeColor:null,
        //                 borderRadius: BorderRadius.circular(12),
        //                 border: Border.all(color: Colors.grey)
        //             ),
        //           )
        //       ],
        //     );
        //   },
        // )

      ],
    );
  }
}





class TopPicksCell extends StatelessWidget {
  final Map iObj;
  const TopPicksCell({super.key, required this.iObj});

  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context).size;
    return SizedBox(
      // color: Colors.red,
        width: media.width * 0.50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 5)
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  iObj["img"].toString(),
                  width: media.width * 0.32,
                  height: media.width * 0.50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              iObj["name"].toString(),
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              iObj["author"].toString(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 11,
              ),
            )
          ],
        ));
  }
}