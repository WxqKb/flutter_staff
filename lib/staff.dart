import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:staff/model/staff_model.dart';

class Staff extends StatelessWidget {
  Staff(this.size, {Key? key}) : super(key: key);
  final Size size;
  final List<StaffModel> _list = [
    StaffModel('e', 1),
    StaffModel('e', 2),
    StaffModel('g', 3),
    StaffModel('e', 4),
    StaffModel('h', 4),
    StaffModel('f', 0),
    StaffModel('e', 1),
    StaffModel('e', 1),
    StaffModel('1', 1),
    StaffModel('2', 3),
    StaffModel('3', 4),
    StaffModel('4', 2),
    StaffModel('5', 3),
    StaffModel('6', 2),
    StaffModel('e', 1),
    StaffModel('g', 1),
    StaffModel("\$", 3),
    StaffModel('e', 2),
    StaffModel('g', 3),
    StaffModel('e', 4),
    StaffModel('h', 4),
    StaffModel('f', 0),
  ];

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: size,
        painter: BaseLinePainter(12, 24, _list.length),
        child: RepaintBoundary(
          child: CustomPaint(
            size: size,
            painter: NotesPainter(_list, 12, 24),
          ),
        ),
      ),
    );
  }
}

/// 绘制5条基线
class BaseLinePainter extends CustomPainter {
  final double lineSpace; // 每条线的间隙
  final double rowSpace; // 每段五线谱的间隙
  final int noteLength; // 音符的长度

  BaseLinePainter(this.lineSpace, this.rowSpace, this.noteLength);

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = Colors.black
      ..isAntiAlias = false
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    double w = size.width;
    int rowCount = (noteLength / 6).ceil(); // 每行6个音符，向上取整
    double h = 0;

    for (int c = 0; c < rowCount; c++) {
      canvas.save();
      h = c * (4 * lineSpace + rowSpace);
      for (int i = 0; i < 5; i++) {
        Path path = new Path();
        path.moveTo(0, h + i * lineSpace);
        path.lineTo(w, h + i * lineSpace);
        canvas.drawPath(path, _paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 音符绘制方法
class NotesPainter extends CustomPainter {
  final List<StaffModel> noteList; // 音符列表
  final double lineSpace; // 每条线的间隙
  final double rowSpace; // 每段五线谱的间隙

  NotesPainter(this.noteList, this.lineSpace, this.rowSpace);

  @override
  void paint(Canvas canvas, Size size) {

    double cellWidth = size.width / 6; // 每个音符的宽度
    double rowTotalHeight = lineSpace * 4 + rowSpace;
    final textStyle = ui.TextStyle(
      fontFamily: 'akvo',
      fontSize: 24, // 这里其实需要根据五线谱每条线之间的空隙来计算字体的size
      color: Colors.brown,
    );
    for (int i = 0; i < noteList.length; i++) {
      canvas.save();
      int rowCount = (i / 6).floor(); // 第几行
      int lineCount = (i % 6); // 第几列
      Offset noteOffset = Offset(lineCount * cellWidth + (cellWidth - 12) / 2,
          rowCount * rowTotalHeight + (noteList[i].level - 1) * lineSpace);

      final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle())
        ..pushStyle(textStyle)
        ..addText(noteList[i].note);
      final paragraph = paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: cellWidth));
      canvas.drawParagraph(paragraph, noteOffset);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
