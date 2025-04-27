import 'package:flutter/material.dart';
import 'package:udb_news/core/utils/helper.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.leading,
    this.suffix,
    required this.title,
  });
  final String title;
  final Widget? leading;
  final Widget? suffix;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppbarState extends State<CustomAppbar> {
  bool isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      leading: widget.leading,
      backgroundColor: Colors.transparent,
      title: Column(
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.blue.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width:
                    isAnimated
                        ? Helper.getTextWidth(
                          text: widget.title,
                          textStyle: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        )
                        : 0,
                height: 2,
                color: Theme.of(context).primaryColor,
              );
            },
          ),
        ],
      ),
      centerTitle: true,
      actions: [widget.suffix ?? SizedBox()],
    );
  }
}
