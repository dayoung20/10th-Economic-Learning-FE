import 'package:flutter/material.dart';

class ProgressTooltip extends StatefulWidget {
  const ProgressTooltip({super.key});

  @override
  State<ProgressTooltip> createState() => _ProgressTooltipState();
}

class _ProgressTooltipState extends State<ProgressTooltip> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isHovering = false;

  void _showTooltip() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 배경 클릭 감지
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideTooltip,
              behavior: HitTestBehavior.translucent,
              child: const SizedBox(),
            ),
          ),
          // 말풍선 툴팁
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 8,
            child: MouseRegion(
              onExit: (_) {
                _hideTooltip();
              },
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 280,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    '학습 레벨에 따른 진도율이 90% 이상인 경우\n다음 단계로 올라갑니다.',
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) {
          _isHovering = true;
          _showTooltip();
        },
        onExit: (_) {
          _isHovering = false;
          Future.delayed(const Duration(milliseconds: 200), () {
            if (!_isHovering) {
              _hideTooltip();
            }
          });
        },
        child: GestureDetector(
          onTap: () {
            if (_overlayEntry == null) {
              _showTooltip();
            } else {
              _hideTooltip();
            }
          },
          child: const Icon(
            Icons.help_outline,
            size: 14,
            color: Color(0xffa2a2a2),
          ),
        ),
      ),
    );
  }
}
