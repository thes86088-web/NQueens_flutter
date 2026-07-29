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
                       child: Cell()                       
                     )	                   
		               )
		            ),
		       );
	}
}

class Cell extends StatefulWidget{
  Cell(/*this.row, this.col, this.canvasSize, */{super.key});
 /* 
  final int row ;
  final int col ;
  final int canvasSize ;
*/  
  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  String state = 'DEFAULT'; //DEFAULT, WITHQUEEN, ATTACKALE
  bool isPlaced = false ;
  
  Color decodeState( String state ){
    Color result = Colors.white ;
    
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
            /*if( state == 'WITHQUEEN' ){
              state = 'DEFAULT' ;
            }
            else {
              state = 'WITHQUEEN';
              
            }*/
          }); 
        } 
      )                  
   ); 
}
}

/*
class Canvas extends StatelessWidget{
    final int canvasSize;
    
    Canvas( this.canvasSize, {
        super.key }
    )
  
    @override
    Widget build( BuildContext context ){
      List<List<Cell>> listOfRows = [ ];
      for( var rowCount = 0; rowCount<canvasSize; rowCount++ ){
        List<Cell> listOfCells = [ ];
        for( var colCount = 0; colCount<canvasSize; colCount++ ){
          Cell tempCell = Cell( rowCount, colCount, canvasSize );
          listOfCells.add( tempCell );
        }
        listOfRows.add( listOfCells );
      }
      return Column( children : listOfRows );
    }
}
*/


