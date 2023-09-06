import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tewos_app/ui/Theme.dart';

import '../../models/rooms.dart';

class RoomTile extends StatelessWidget {
  final Rooms? room;
   RoomTile(this.room);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:EdgeInsets.symmetric(horizontal: 20) ,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 12),
        child:Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color:_getBGClr(room?.color??0),
          ),
          child: Row(
            children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(room?.name??"",style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,color: Colors.white
                  ),
                  ),
                   SizedBox(height: 12,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.people,color: Colors.grey[200],size: 18,),
                      SizedBox(width: 4,),
                    Text("${room?.numberOfPeople}",style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,color: Colors.white
                  ),
                  ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.bed_outlined,color: Colors.grey[200],size: 18,),
                      SizedBox(width: 4,),
                      Text(
                        "${room!.type}",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(fontSize: 13,color: Colors.grey[100]),
                        ),
                      )
                    ],
                  ),
                
                    ],
                  ),
            ),
                    
             Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 0.5,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
             
          ],),
        )
    );
  }
  _getBGClr(int no){
    switch(no){
       case 0:
       return bluishClr;
       case 1:
       return pinkClr;
       case 2:
       return yellowClr;
       default:
       return bluishClr;
    }
  }
}