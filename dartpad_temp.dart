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
                     //child : Expanded (
                       child: Canvas(8)                      
                     //)	                   
		               )
		            ),
		       );
	}
}

class CellData {
  CellData(this.row, this.col, this.stateString /*this.canvasSize*/);
 
  final int row ;
  final int col ;
  String stateString ;
}

class Cell extends StatefulWidget{
  Cell(this.cellData, this.triggerChanges, /*this.canvasSize,*/{super.key});
 
  final CellData cellData;
  final void Function( int, int ) triggerChanges ;
  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  //String state = 'D' ;
  //String state = widget.cellData.state_string; //DEFAULT, WITHQUEEN, ATTACKALE
  bool isPlaced = false ;
  
  Color decodeState( String state ){
    Color result = Colors.yellow ;
    /*when same color is repeated, 
    try adding a new color at either place 
    to test/ensure proper logic
    */
    
    if( state == 'Q' ){
      result = Colors.green ;
    }
    else{
      if( state == 'A' ){
        result = Colors.lime ;
      }
      //else {result = Colors.white ; }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container( 
      //color : decodeState(state), 
      decoration: BoxDecoration(
          color: decodeState( widget.cellData.stateString ),
          border: Border.all(color: Colors.grey.shade400, width: 0.5)
        ),
      child : GestureDetector(
        onTap : () { 
          setState( () { 
            widget.cellData.stateString = 
            ( widget.cellData.stateString == 'Q') ? 'D' : 'Q' ;
           }
         ); 
        } 
      )                  
   ); 
}
}


class Canvas extends StatefulWidget{
    final int canvasSize;
  
    Canvas( this.canvasSize, {
        super.key }
    );
      
    @override
    State<Canvas> createState( ) => _CanvasState( );
}

class _CanvasState extends State<Canvas>{
  late List<List<CellData>> canvasData ;
  
  @override
  void initState() {
    super.initState();
    canvasData = _initCanvas();
  }
   
  List<List<CellData>> _initCanvas( ){
    List<List<CellData>> result = [];
    for( var row = 0; row < widget.canvasSize; row++  ){
      List<CellData> tempRow = [];
      for( var col = 0; col < widget.canvasSize; col++  ){
        tempRow.add( CellData( row, col, 'D' ) );
      }
      result.add( tempRow );
    }
    return result ;
  } 
  
  void highlightAttackableCells( int epicenterRow, int epicenterCol ){
    List<List<CellData>> newCanvasData = [];
    for( int row = 0; row < epicenterRow ; row++ ){
      List<CellData> newTempRow = [];
      for( int col = 0; col < epicenterCol; col++ ){
        CellData tempCellData = CellData( row, col, 'D' );
        if( row == epicenterRow || col == epicenterCol ){
           if( canvasData[row][col].stateString == 'D' ) {
             tempCellData.stateString = 'A' ;
             //newCanvasData[row][col].stateString = 'A'; 
           }
        }
        newTempRow.add( tempCellData );
      }
      newCanvasData.add( newTempRow );
    }
    setState( (){ canvasData = newCanvasData ; } );
  } 

    @override
    Widget build( BuildContext context ){
      List< Row > columnChildren = [];
      for( var row = 0; row < widget.canvasSize; row++  ){
        //List< Row > tempRowChildren = [];
        List< Cell > tempRowChildren = [];
        for( var col = 0; col < widget.canvasSize; col++  ){
          /*
            Row cellBlock = Row(
              children : [ SizedBox( width : 10 ), Cell( canvas[row][col] )] 
            );
           */
          tempRowChildren.add( Cell( canvasData[row][col], 
                                    highlightAttackableCells ) ) ;
        }
        Row tempRow = Row( children : tempRowChildren );
        columnChildren.add( tempRow ) ;
      }
     return Column( children : columnChildren ) ;
  }

}


