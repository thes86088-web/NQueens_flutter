import 'package:flutter/material.dart';

void main() {
	runApp(MainApp());
}

class MainApp extends StatelessWidget {
	const MainApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
		           home: Scaffold(
		               body:  Center(
                     child : Expanded (
                       child: Canvas(8)                       
                     )	                   
		               )
		            ),
		       );
	}
}

class CellData {
  CellData(this.row, this.col, /*this.canvasSize*/);
 
  final int row ;
  final int col ;
}

class Cell extends StatefulWidget{
  Cell(this.cellData, /*this.canvasSize,*/{super.key});
 
  final CellData cellData;  
  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  String state = 'DEFAULT'; //DEFAULT, WITHQUEEN, ATTACKALE
  bool isPlaced = false ;
  
  Color decodeState( String state ){
    Color result = Colors.yellow ;
    
    if( state == 'WITHQUEEN' ){
      result = Colors.green ;
    }
    else{
      if( state == 'ATTACKABLE' ){
        result = Colors.lime ;
      }
      else {result = Colors.white ; }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container( 
      color : decodeState(state),
      child : GestureDetector(
        onTap : () { 
          setState( () { 
            state = (state == 'WITHQUEEN') ? 'DEFAULT' : 'WITHQUEEN' ;
           }); 
        } 
      )                  
   ); 
}
}


class Canvas extends StatefulWidget{
    final int canvasSize;
  
    Canvas( this.canvasSize, {
        super.key }
    )
      
    @override
    State<Canvas> createState( ) => _CanvasState( );
}

class _CanvasState extends State<Canvas>{
  late List<List<CellData>> canvas ;
  
  @override
  void initState() {
    super.initState();
    canvas = _initCanvas();
  }
   
  List<List<CellData>> _initCanvas( ){
    List<List<CellData>> result = [];
    for( var row = 0; row < widget.canvasSize; row++  ){
      List<CellData> tempRow = [];
      for( var col = 0; col < widget.canvasSize; col++  ){
        tempRow.add( CellData( row, col ) );
      }
      result.add( tempRow );
    }
    return result ;
  } 

    @override
    Widget build( BuildContext context ){
      List< Row > columnChildren = [];
      for( var row = 0; row < widget.canvasSize; row++  ){
        List< Row > tempRowChildren = [];
        for( var col = 0; col < widget.canvasSize; col++  ){
          Row cellBlock = Row(
              children : [ SizedBox( width : 10 ), Cell( canvas[row][col] )] 
            );
          tempRowChildren.add( cellBlock ) ;
        }
        Row tempRow = Row( children : tempRowChildren );
        columnChildren.add( tempRow ) ;
      }
     return Column( children : columnChildren ) ;
  }

}

