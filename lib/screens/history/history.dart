import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class History extends StatefulWidget {
  const History({super.key});
  static const String id = 'History';
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        8,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Container(
                height: 280,
                child: Center(
                    child: Text(
                  "Page $index",
                  style: TextStyle(color: Colors.indigo),
                )),
              ),
            ));
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 50),
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: controller,
            // itemCount: pages.length,
            itemBuilder: (_, index) {
              return pages[index % pages.length];
            },
          ),
        ),
        SizedBox(height: 10),
        SmoothPageIndicator(
            controller: controller,
            count: pages.length,
            effect: ScrollingDotsEffect(
              activeStrokeWidth: 2.6,
              activeDotScale: 1.3,
              maxVisibleDots: 5,
              radius: 8,
              spacing: 10,
              dotHeight: 12,
              dotWidth: 12,
            )),
      ],
    ));
  }
}
