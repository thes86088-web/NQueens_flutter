import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: Canvas(8),
            ),
          ),
        ),
      ),
    );
  }
}

class CellData {
  CellData(this.row, this.col, this.stateString);
  final int row;
  final int col;
  String stateString; // 'D' = default, 'Q' = queen, 'A' = attackable
}

class Cell extends StatelessWidget {
  const Cell(this.cellData, this.onTap, {super.key});

  final CellData cellData;
  final VoidCallback onTap;

  Color _decodeState(String state) {
    switch (state) {
      case 'Q':
        return Colors.green;
      case 'A':
        return Colors.lime;
      default:
        return Colors.yellow.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _decodeState(cellData.stateString),
          border: Border.all(color: Colors.black, width: 0.5),
        ),
      ),
    );
  }
}

class Canvas extends StatefulWidget {
  const Canvas(this.canvasSize, {super.key});
  final int canvasSize;

  @override
  State<Canvas> createState() => _CanvasState();
}

class _CanvasState extends State<Canvas> {
  late List<List<CellData>> canvasData;

  @override
  void initState() {
    super.initState();
    canvasData = _initCanvas();
  }

  List<List<CellData>> _initCanvas() {
    return List.generate(
      widget.canvasSize,
      (row) => List.generate(
        widget.canvasSize,
        (col) => CellData(row, col, 'D'),
      ),
    );
  }

  /// Clears all 'A' marks, then (optionally) highlights attacks from every queen.
  void _recomputeAttacks() {
    // 1. Reset every non-queen cell to 'D'
    for (final row in canvasData) {
      for (final cell in row) {
        if (cell.stateString != 'Q') cell.stateString = 'D';
      }
    }

    // 2. For every queen, mark its attack lines
    for (int r = 0; r < widget.canvasSize; r++) {
      for (int c = 0; c < widget.canvasSize; c++) {
        if (canvasData[r][c].stateString == 'Q') {
          _markAttacksFrom(r, c);
        }
      }
    }
  }

  void _markAttacksFrom(int epicenterRow, int epicenterCol) {
    final n = widget.canvasSize;

    // Same row
    for (int c = 0; c < n; c++) {
      if (c != epicenterCol && canvasData[epicenterRow][c].stateString == 'D') {
        canvasData[epicenterRow][c].stateString = 'A';
      }
    }

    // Same column
    for (int r = 0; r < n; r++) {
      if (r != epicenterRow && canvasData[r][epicenterCol].stateString == 'D') {
        canvasData[r][epicenterCol].stateString = 'A';
      }
    }

    // Diagonals
    for (int i = 1; i < n; i++) {
      // ↘
      if (epicenterRow + i < n && epicenterCol + i < n &&
          canvasData[epicenterRow + i][epicenterCol + i].stateString == 'D') {
        canvasData[epicenterRow + i][epicenterCol + i].stateString = 'A';
      }
      // ↙
      if (epicenterRow + i < n && epicenterCol - i >= 0 &&
          canvasData[epicenterRow + i][epicenterCol - i].stateString == 'D') {
        canvasData[epicenterRow + i][epicenterCol - i].stateString = 'A';
      }
      // ↗
      if (epicenterRow - i >= 0 && epicenterCol + i < n &&
          canvasData[epicenterRow - i][epicenterCol + i].stateString == 'D') {
        canvasData[epicenterRow - i][epicenterCol + i].stateString = 'A';
      }
      // ↖
      if (epicenterRow - i >= 0 && epicenterCol - i >= 0 &&
          canvasData[epicenterRow - i][epicenterCol - i].stateString == 'D') {
        canvasData[epicenterRow - i][epicenterCol - i].stateString = 'A';
      }
    }
  }

  void _onCellTapped(int row, int col) {
    setState(() {
      final cell = canvasData[row][col];
      cell.stateString = (cell.stateString == 'Q') ? 'D' : 'Q';
      _recomputeAttacks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.canvasSize, (row) {
        return Expanded(
          child: Row(
            children: List.generate(widget.canvasSize, (col) {
              return Expanded(
                child: Cell(
                  canvasData[row][col],
                  () => _onCellTapped(row, col),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
