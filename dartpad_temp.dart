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

class Canvas extends StatelessWidget{
    final int canvasSize;
    
    Canvas( this.canvasSize, {
        super.key }
    )
  
   
  
    @override
    Widget build( BuildContext context ){
      List<Row> listOfRows = [ ];
      for( var rowCount = 0; rowCount<canvasSize; rowCount++ ){
        List<Cell> listOfCells = [ ];
        for( var cellCount = 0; cellCount<canvasSize; cellCount++ ){
          Cell tempCell = Cell();
          listOfCells.add( tempCell );
        }
        Row tempRow = Row( child : listOfCells );
        listOfRows.add( tempRow );
      }
      return Column( children : listOfRows );
    }
	}
}

