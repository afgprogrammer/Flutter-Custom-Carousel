import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  )
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<List<String>> products = [
    [
      'assets/images/watch-1.jpg',
      'Hugo Boss Oxygen',
      '100 \$'
    ],
    [
      'assets/images/watch-2.jpg',
      'Hugo Boss Signature',
      '120 \$'
    ],
    [
      'assets/images/watch-3.jpg',
      'Casio G-Shock Premium',
      '80 \$'
    ]
  ];

  int currentIndex = 0;

  void _next() {
    setState(() {
      if (currentIndex < products.length -1) {
        currentIndex++;
      } else {
        currentIndex = currentIndex;
      }
    });
  }

  void _preve() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  _preve();
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  _next();
                }
              },
              child: FadeInUp(duration: Duration(milliseconds: 800), child: Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(products[currentIndex][0]),
                    fit: BoxFit.cover
                  )
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.grey.shade700.withOpacity(.9),
                        Colors.grey.withOpacity(.0),
                      ]
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FadeInUp(duration: Duration(milliseconds: 1000), child: Container(
                        width: 90,
                        margin: EdgeInsets.only(bottom: 60),
                        child: Row(
                          children: _buildIndicator(),
                        ),
                      ))
                    ],
                  ),
                ),
              )),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, -40),
                child: FadeInUp(duration: Duration(milliseconds: 1000), child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          FadeInUp(duration: Duration(milliseconds: 1300), child: Text(products[currentIndex][1], style: TextStyle(color: Colors.grey[800], fontSize: 40, fontWeight: FontWeight.bold),)),
                          SizedBox(height: 15,),
                          Row(
                            children: <Widget>[
                              FadeInUp(duration: Duration(milliseconds: 1400), child: Text(products[currentIndex][2], style: TextStyle(color: Colors.yellow[700], fontWeight: FontWeight.bold, fontSize: 20),)),
                              SizedBox(width: 10,),
                              FadeInUp(duration: Duration(milliseconds: 1500), child: Row(
                                children: <Widget>[
                                  Icon(Icons.star, size: 18, color: Colors.yellow[700],),
                                  Icon(Icons.star, size: 18, color: Colors.yellow[700],),
                                  Icon(Icons.star, size: 18, color: Colors.yellow[700],),
                                  Icon(Icons.star, size: 18, color: Colors.yellow[700],),
                                  Icon(Icons.star_half, size: 18, color: Colors.yellow[700],),
                                  SizedBox(width: 5,),
                                  Text("(4.2/70 reviews)", style: TextStyle(color: Colors.grey, fontSize: 12),)
                                ],
                              ))
                            ],
                          ),
                        ],
                      ),
                      FadeInUp(duration: Duration(milliseconds: 1700), child: MaterialButton(
                        onPressed: () {},
                        height: 45,
                        color: Colors.yellow[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Center(
                          child: Text("ADD TO CART", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      )),
                    ],
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 4,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isActive ? Colors.grey[800] : Colors.white
        ),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for(int i = 0; i < products.length; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
