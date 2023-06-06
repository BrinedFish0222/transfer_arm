import 'package:flutter/material.dart';

/// 转圈圈组件
class RotatingWidget extends StatefulWidget {
  const RotatingWidget({Key? key, required this.isStop, required this.child}) : super(key: key);  
  
  final Widget child;  
  /// 是否停止
  final bool isStop;  
  @override  
  State<RotatingWidget> createState() => _RotatingWidgetState();  
}  
  
class _RotatingWidgetState extends State<RotatingWidget>  
    with SingleTickerProviderStateMixin {  
  late final AnimationController _animationController;  
  late final Animation<double> _animation;  
  
  @override  
  void initState() {  
    super.initState();  
  
    _animationController = AnimationController(  
      duration: const Duration(seconds: 1),  
      vsync: this,  
    )..repeat();  
  
    _animation = CurvedAnimation(  
      parent: _animationController,  
      curve: Curves.linear,  
    );  
  }  
  
  @override  
  void dispose() {  
    _animationController.dispose();  
    super.dispose();  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return widget.isStop ? widget.child : RotationTransition(  
      turns: _animation,  
      child: widget.child,  
    );  
  }  
}