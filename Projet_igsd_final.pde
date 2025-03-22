import processing.sound.*;
PShape terrain;
PImage texture;
PShader levelShaders;
float xCam = 0, yCam = 50, zCam = -170;;
float zDirCam = zCam - 20; 
float targetX, targetY, targetZ;
boolean doEoliennes = true;
boolean doPylons = true;
boolean doCables = true;
PShape pylon;
SoundFile wind;



boolean move=false;
//int lastMouseStopX, lastMouseStopY, prevCameraX, prevCameraY, prevCameraZ;

void setup() {
  size(800, 600, P3D);
  cameraZ=(height/2.0)/tan(fov/2.0);
  texture = loadImage("StAuban_texture.jpg");
  terrain = loadShape("hypersimple.obj");
  levelShaders = loadShader("fragmentShader.glsl", 
               "vertexShader.glsl");
  wind = new SoundFile(this,"wind.mp3");
  wind.play();
  wind.loop();
  perspective(PI/3.0, width/height, 1, 1500);
  
  pylon = createPylon();
  //pylon.scale(0.3);
  e = new GeneratorE();
  e.resizable(0.005);
  p = e.getShape();
  noCursor();
}

void draw() {
  shader(levelShaders);
  background(255);
  strokeWeight(1);
  translate (width/2, height/2);
  camera(xCam, yCam, zCam, 0, -1, zDirCam, 0, 0, -1);
  pushMatrix();
  
  beginShape(LINES);
  if(doPylons)drawPylons();
  //drawAxes();
  if(doEoliennes)draweolienne();
  updateCamera();
  endShape();
  
  popMatrix();
 
  shape(terrain);
}
void draweolienne() {
  e.animate(PI/16);
  float x = 20;
  float y = -60;
  float endx = 40;
  float endy = -80;
  
  placeEol(p, x, y, endx, endy, terrain);
  shape(p);
}
void drawPylons() {
  // Exemple de position de départ et d'arrivée pour une ligne de pylônes
  float startX = 32;
  float startY = -70;
  float endX = 20;
  float endY = 100;
  int numPylons = 26; // Nombre de pylônes à placer entre les points de départ et d'arrivée
  
  // Appeler placeObjects pour placer les pylônes et dessiner les câbles
  placeObjects(pylon, startX, startY, endX, endY, numPylons, terrain);
}

void updateCamera() {
  // Positionner la caméra
  camera(xCam,yCam, zCam, targetX, targetY, targetZ, 0, 1, 0);
  
  // Gérer les contrôles de la caméra
  if (keyPressed) {
    if (key == 'w') yCam += 10;
    if (key == 's') yCam -= 10;
    if (key == 'a') xCam += 10;
    if (key == 'd') xCam -= 10;
  }
  
  if (mousePressed && mouseY < height - 100) {
    float deltaX = radians(mouseX - pmouseX);
    float deltaY = radians(mouseY + pmouseY);
    
    xCam += cos(deltaX) * 10;
    zCam += sin(deltaX) * 10;
    yCam -= sin(deltaY) * 10;
  }
}


void drawAxes(){
  
  translate(0,0,-195); 
  strokeWeight(2);
  
  
  // Axe x (rouge)
  stroke(255, 0, 0);
  line(0, 0, 0, 100, 0, 0);
  
  // Axe y (vert)
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 100, 0);
  
  // Axe z (bleu)
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 100);
  
}
