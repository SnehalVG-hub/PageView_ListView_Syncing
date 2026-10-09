import 'package:flutter/material.dart';

void main() {
  runApp(PageListViewSyncing());
}

class PageListViewSyncing extends StatelessWidget {
  const PageListViewSyncing({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  List<int> shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.purple,
    Colors.lightGreen,
    Colors.lime,
    Colors.pink,
  ];
  int selectedIndex = 0;

  final GlobalKey listViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    physics: CarouselScrollPhysics(),
                    itemCount: colors.length * shades.length,
                    onPageChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });

                      if (!scrollController.hasClients) return;

                      final RenderBox? listBox =
                          listViewKey.currentContext?.findRenderObject()
                              as RenderBox?;

                      if (listBox == null) return;

                      final double itemHeight = 80;
                      final double listHeight = listBox.size.height;

                      final double selectedItemCenter =
                          (index * itemHeight) + (itemHeight / 2);

                      final double targetOffset =
                          (selectedItemCenter - listHeight / 2).clamp(
                            0.0,
                            scrollController.position.maxScrollExtent,
                          );

                      if ((scrollController.offset - targetOffset).abs() > 2) {
                        scrollController.jumpTo(targetOffset);
                      }
                    },
                    itemBuilder: (context, index) {
                      int colorIndex = index ~/ shades.length;
                      int shadeIndex = index % shades.length;
                      MaterialColor color = colors[colorIndex];
                      int shade = shades[shadeIndex];
                      return Container(
                        color: color[shade],
                        child: Center(
                          child: Text('$shade', style: TextStyle(fontSize: 40)),
                        ),
                      );
                    },
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: ListView.builder(
                    key: listViewKey,
                    controller: scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: shades.length * colors.length,

                    itemBuilder: (context, index) {
                      int colorIndex = index ~/ shades.length; // ~/ means round os division, shades.length is 10 and instead of wrote 10 we wrote shades.length or u can also write 10
                      int shadeIndex =
                          index % shades.length; // % means remainder

                      MaterialColor color = colors[colorIndex];
                      int shade = shades[shadeIndex];
                      return GestureDetector(
                        onTap: () {
                          pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },

                        child: Container(
                          height: 80,

                          decoration: BoxDecoration(
                            color: color[shade],
                            border: Border.all(
                              color: selectedIndex == index
                                  ? Colors.black
                                  : Colors.white,
                              width: selectedIndex == index ? 4 : 0,
                            ),
                          ),

                          child: Center(
                            child: Text(
                              '$shade',
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
