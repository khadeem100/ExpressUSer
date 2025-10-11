import 'package:get/get.dart';
import 'package:demandium/utils/core_export.dart';

class TitleWidget extends StatefulWidget {
  final String? title;
  final TextDecoration? textDecoration;
  final Function()? onTap;
  const TitleWidget({super.key, required this.title, this.onTap, this.textDecoration});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            widget.title!.tr,
            style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge,
              letterSpacing: -0.5,
              fontWeight: FontWeight.w700,
              color: widget.title == 'recently_view_services'
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: .9),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        (widget.onTap != null)
            ? GestureDetector(
                onTapDown: (_) => _controller.forward(),
                onTapUp: (_) {
                  _controller.reverse();
                  widget.onTap!();
                },
                onTapCancel: () => _controller.reverse(),
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'see_all'.tr,
                          style: robotoMedium.copyWith(
                            decoration: widget.textDecoration,
                            color: Get.isDarkMode
                                ? Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: .8)
                                : widget.title == 'recently_view_services'
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.primary,
                            fontSize: Dimensions.fontSizeLarge,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SlideTransition(
                          position: _slideAnimation,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: Get.isDarkMode
                                ? Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: .8)
                                : widget.title == 'recently_view_services'
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
