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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(color: Colors.red),
                      Container(color: Colors.yellow),
                      Container(color: Colors.lime),
                      Container(color: Colors.purple),
                      Container(color: Colors.redAccent),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: shades.length * colors.length,
                    itemBuilder: (context, index) {
                      int colorIndex = index ~/ shades.length; // ~/ means round os division, shades.length is 10 and instead of wrote 10 we wrote shades.length or u can also write 10
                      int shadeIndex =
                          index % shades.length; // % means remainder

                      MaterialColor color = colors[colorIndex];
                      int shade = shades[shadeIndex];
                      return Container(
                        height: 80,
                        color: color[shade],
                        child: Center(child: Text('$shade')),
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
