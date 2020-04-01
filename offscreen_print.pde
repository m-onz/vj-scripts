
/*
Use an offscreen buffer to generate a big high resolution image
suitable for print media or websites like behance
*/

PGraphics big;

void setup () {
  size(640, 480);

  big = createGraphics(2800, 1039);
  big.smooth();
  big.beginDraw(); 
  big.background(222,29,1);
  big.stroke(255);
  big.strokeWeight(4);
  for(int i = 0; i < width; i++) {
     big.line(i*10, 0, height, i*10); 
  }
  big.endDraw();
  // change the file extension here...
  // .tif
  // .jpg
  big.save("big.png");

}

void draw () {}
