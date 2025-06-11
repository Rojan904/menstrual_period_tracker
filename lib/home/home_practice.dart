import 'package:flutter/material.dart';
import 'package:roam_app/config/themes/theme_config.dart';

class HomePractice extends StatefulWidget {
  const HomePractice({Key? key}) : super(key: key);

  @override
  State<HomePractice> createState() => _HomePracticeState();
}

class _HomePracticeState extends State<HomePractice> {
  late ScrollController scrollController;
  double scrollOffset = 0.0;

  scrollListener() {
    setState(() {
      scrollOffset = scrollController.offset;
    });
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        child: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                // SliverToBoxAdapter(
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * 1.5,
                //     child: Center(
                //       child: Text(
                //         "Pull",
                //         style: TextStyle(color: Colors.black, fontSize: 70),
                //       ),
                //     ),
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1.5,
                    color: Colors.blue,
                    child: Container(
                      height: 500,
                      color: Colors.red,
                      child: DraggableScrollableSheet(
                        initialChildSize: 0.5,
                        minChildSize: 0.5,
                        maxChildSize: 1,
                        builder: (context, scrollController) {
                          return Text(
                            "Pull",
                            style: TextStyle(color: Colors.black, fontSize: 70),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 40),
                child: FadeAppBar(
                  offset: scrollOffset,
                ))
          ],
        ),
      ),
    );
  }
}

class FadeAppBar extends StatelessWidget {
  const FadeAppBar({Key? key, required this.offset}) : super(key: key);
  final double offset;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 100,
        padding: EdgeInsets.all(8),
        color: Colors.white.withOpacity((offset / 350).clamp(0, 1).toDouble()),
        child: Text(
          "data",
          style: textThemes(context).bodyLarge,
        ),
      ),
    );
  }
}
