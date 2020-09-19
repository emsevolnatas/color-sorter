import java.util.LinkedList;

PFont f;
char c = 'G';
int n = 255;
final int WIDTH = 600;
final int HEIGHT = 600;
int circleRadius = 200;
String message = " ";
int circle[] = new int[n];
LinkedList<Integer> lines = new LinkedList<Integer>();;

void setup() {
  size(600,600);
  f = createFont("Comic Sans MS",32,true);
  for(int i = 0; i <= n; i++) {
    lines.add(i);
  }
  
  for(int i = 0; i< n; i++) {
    int rand = (int)random(lines.size());
        circle[i] = lines.get(rand);
        lines.remove(rand);
  }
  colorMode(RGB, 255);
}

void draw() {  // draw() loops forever, until stopped
  float betweenLines = 2.0*PI/circle.length;
  background(0xffffff);
  textFont(f,32);
  fill(0);
  textAlign(CENTER);
  text("press spacebar to sort",WIDTH/2,HEIGHT/2+circleRadius+80);

  for(int i = 0; i < circle.length; i++) {
    int temp = circle[i];
    float x = cos(betweenLines*i)*circleRadius+WIDTH/2;
    float y = sin(betweenLines*i)*circleRadius+HEIGHT/2;
    switch(c) {
      case 'R': stroke(temp, 0, 0); break;
      case 'G': stroke(0, temp, 0); break;
      case 'B': stroke(0, 0, temp); break;
      default : stroke(temp); break;
    }
    
    strokeWeight(7);
    line(WIDTH/2,HEIGHT/2,x,y);
  } 
  fill(color(255,0,0));  
  textFont(f,200);
  text(message,WIDTH/2,HEIGHT/2);
}

void sortCircle() {
  triRapide(circle, 0, circle.length-1);
}

public void triRapide(int[] tab, int iDep, int iFin) {
    if(iDep<iFin) {
        int p = partitioner(tab, iDep, iFin);
        triRapide(tab, iDep, p-1);
        triRapide(tab, p+1, iFin);
    }
}


/**
 * On cherche le point du pivot,
 * On peut également le faire de manière arbitraire ou aléatoire
 * @return le point de pivot
 */
 int partitioner(int[] tab, int iDep, int iFin) {
    int pivot = tab[iFin];
    int i = iDep;
    for (int j = iDep; j < iFin; j++)
        if(tab[j]<pivot)
            permuter(tab, i++, j);

    permuter(tab, i, iFin);
    return i;
}

/** Échanges les deux cases du tableau passé en paramètre */
private static void permuter(int[] tab, int i, int j) {
    int temp = tab[i];
    tab[i] = tab[j];
    tab[j] = temp;
}
