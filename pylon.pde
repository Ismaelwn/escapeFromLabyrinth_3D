float pylonWidth = 0.3; // Largeur du pylône
float pylonHeight = 5; // Hauteur du pylône
PShape createPylon() {
  PShape p = createShape(GROUP); // Créer un groupe pour contenir les segments de pylône

  
  float numSegments = pylonHeight/pylonWidth; // Nombre de segments de pylône

  float segmentHeight = pylonHeight / numSegments; // Hauteur de chaque segment de pylône

  for (int i = 0; i < numSegments; i++) {
    PShape linesSegment = createShape(); // Créer un segment de pylône
    linesSegment.beginShape(LINES);
    linesSegment.strokeWeight(1); // Définir l'épaisseur des lignes
    float z = i * segmentHeight; // Coordonnee z de l'image courante 
    float nextZ = (i + 1) * segmentHeight;
    float halfWidth = pylonWidth / 2;

    // Dessiner des carrés au niveau z et z + segmentHeight
    linesSegment.vertex(-halfWidth, -halfWidth, z);
    linesSegment.vertex(halfWidth, -halfWidth, z);
    linesSegment.vertex(halfWidth, -halfWidth, z);
    linesSegment.vertex(halfWidth, halfWidth, z);
    linesSegment.vertex(halfWidth, halfWidth, z);
    linesSegment.vertex(-halfWidth, halfWidth, z);
    linesSegment.vertex(-halfWidth, halfWidth, z);
    linesSegment.vertex(-halfWidth, -halfWidth, z);

    linesSegment.vertex(-halfWidth, -halfWidth, nextZ);
    linesSegment.vertex(halfWidth, -halfWidth, nextZ);
    linesSegment.vertex(halfWidth, -halfWidth, nextZ);
    linesSegment.vertex(halfWidth, halfWidth, nextZ);
    linesSegment.vertex(halfWidth, halfWidth, nextZ);
    linesSegment.vertex(-halfWidth, halfWidth, nextZ);
    linesSegment.vertex(-halfWidth, halfWidth, nextZ);
    linesSegment.vertex(-halfWidth, -halfWidth, nextZ);

    // Connexions verticales
    linesSegment.vertex(-halfWidth, -halfWidth, z);
    linesSegment.vertex(-halfWidth, -halfWidth, nextZ);
    linesSegment.vertex(halfWidth, -halfWidth, z);
    linesSegment.vertex(halfWidth, -halfWidth, nextZ);
    linesSegment.vertex(halfWidth, halfWidth, z);
    linesSegment.vertex(halfWidth, halfWidth, nextZ);
    linesSegment.vertex(-halfWidth, halfWidth, z);
    linesSegment.vertex(-halfWidth, halfWidth, nextZ);

    // Dessiner toutes les diagonales de chaque face
    // Diagonales de la face inférieure
    linesSegment.vertex(-halfWidth, -halfWidth, z);
    linesSegment.vertex(halfWidth, halfWidth, z);
    linesSegment.vertex(halfWidth, -halfWidth, z);
    linesSegment.vertex(-halfWidth, halfWidth, z);

    // Diagonales verticales entre les bases
    linesSegment.vertex(-halfWidth, -halfWidth, z);
    linesSegment.vertex(-halfWidth, halfWidth, nextZ);
    linesSegment.vertex(-halfWidth, halfWidth, z);
    linesSegment.vertex(-halfWidth, -halfWidth, nextZ);
    linesSegment.vertex(halfWidth, halfWidth, z);
    linesSegment.vertex(halfWidth, -halfWidth, nextZ);
    linesSegment.vertex(halfWidth, -halfWidth, z);
    linesSegment.vertex(halfWidth, halfWidth, nextZ);
    linesSegment.vertex(halfWidth, halfWidth, z);
    linesSegment.vertex(-halfWidth, halfWidth, nextZ);
    linesSegment.vertex(-halfWidth, -halfWidth, z);
    linesSegment.vertex(halfWidth, -halfWidth, nextZ);
    linesSegment.vertex(halfWidth, -halfWidth, z);
    linesSegment.vertex(-halfWidth, -halfWidth, nextZ);
    linesSegment.vertex(-halfWidth, halfWidth, z);
    linesSegment.vertex(halfWidth, halfWidth, nextZ);


    linesSegment.endShape();
    p.addChild(linesSegment);
  }

  // Ajout du triangle au sommet
  PShape triangleSegment = createShape();
  triangleSegment.beginShape(LINES);
  triangleSegment.strokeWeight(1);  // Définit l'épaisseur des lignes
  float topZ = pylonHeight;
  float baseWidth = pylonWidth*6;
  float halfBaseWidth = baseWidth / 2;
  float tipZ = topZ + pylonWidth;
  
  // Définir les sommets du triangle et connecter les lignes
  // Base du triangle
  triangleSegment.vertex(-halfBaseWidth, pylonWidth / 2, topZ); // Point gauche de la base
  triangleSegment.vertex(halfBaseWidth, pylonWidth / 2, topZ); // Point droit de la base
  triangleSegment.vertex(halfBaseWidth, pylonWidth / 2, topZ);
  triangleSegment.vertex(0, pylonWidth / 2, tipZ); // Sommet du triangle
  triangleSegment.vertex(0, pylonWidth / 2, tipZ);
  triangleSegment.vertex(-halfBaseWidth, pylonWidth / 2, topZ);
  triangleSegment.vertex(-halfBaseWidth, -pylonWidth / 2, topZ); // Point gauche de la base
  triangleSegment.vertex(halfBaseWidth, -pylonWidth / 2, topZ); // Point droit de la base
  triangleSegment.vertex(halfBaseWidth, -pylonWidth / 2, topZ);
  triangleSegment.vertex(0, -pylonWidth / 2, tipZ); // Sommet du triangle
  triangleSegment.vertex(0, -pylonWidth / 2, tipZ);
  triangleSegment.vertex(-halfBaseWidth, -pylonWidth / 2, topZ);
  triangleSegment.vertex(-halfBaseWidth, -pylonWidth / 2, topZ); // Point gauche de la base
  triangleSegment.vertex(-halfBaseWidth, pylonWidth / 2, topZ);  // Point gauche de la base
  triangleSegment.vertex(halfBaseWidth, -pylonWidth / 2, topZ);// Point droit de la base
  triangleSegment.vertex(halfBaseWidth, pylonWidth / 2, topZ);// Point droit de la base
  triangleSegment.vertex(0, -pylonWidth / 2, tipZ);// Sommet du triangle
  triangleSegment.vertex(0, pylonWidth / 2, tipZ);// Sommet du triangle
// Calcul des points de base gauche des deux triangles
float topTriangleBaseLeftX = -halfBaseWidth;
float bottomTriangleBaseLeftX = -halfBaseWidth;

// Sommet du triangle pour les deux triangles
float topTriangleTipX = 0;
float bottomTriangleTipX = 0;

// Coordonnées Z et Y constantes

float yTop = pylonWidth / 2;
float yBottom = -pylonWidth / 2;

// Ajout de lignes parallèles le long de l'arête gauche des deux triangles
for (int i = 1; i <= 5; i++) {
  float fraction = i / 6.0; // Fraction du chemin entre le sommet et la base gauche

  // Coordonnées interpolées pour le triangle du haut
  float interpTopX = lerp(topTriangleTipX, topTriangleBaseLeftX, fraction);
  float interpTopY = lerp(yTop, yTop, fraction); // Y reste constant
  float interpTopZ = lerp(tipZ, topZ, fraction);

  // Coordonnées interpolées pour le triangle du bas
  float interpBottomX = lerp(bottomTriangleTipX, bottomTriangleBaseLeftX, fraction);
  float interpBottomY = lerp(yBottom, yBottom, fraction); // Y reste constant
  float interpBottomZ = lerp(tipZ, topZ, fraction);

  // Dessiner les lignes parallèles
  triangleSegment.vertex(interpTopX, interpTopY, interpTopZ);
  triangleSegment.vertex(interpBottomX, interpBottomY, interpBottomZ);
}
// Calcul des points de base droite des deux triangles
float topTriangleBaseRightX = halfBaseWidth;
float bottomTriangleBaseRightX = halfBaseWidth;



// Ajout de lignes parallèles le long de l'arête droite des deux triangles
for (int i = 1; i <= 5; i++) {
  float fraction = i / 6.0; // Fraction du chemin entre le sommet et la base droite

  // Coordonnées interpolées pour le triangle du haut
  float interpTopX = lerp(topTriangleTipX, topTriangleBaseRightX, fraction);
  float interpTopY = lerp(yTop, yTop, fraction); // Y reste constant
  float interpTopZ = lerp(tipZ, topZ, fraction);

  // Coordonnées interpolées pour le triangle du bas
  float interpBottomX = lerp(bottomTriangleTipX, bottomTriangleBaseRightX, fraction);
  float interpBottomY = lerp(yBottom, yBottom, fraction); // Y reste constant
  float interpBottomZ = lerp(tipZ, topZ, fraction);

  // Dessiner les lignes parallèles
  triangleSegment.vertex(interpTopX, interpTopY, interpTopZ);
  triangleSegment.vertex(interpBottomX, interpBottomY, interpBottomZ);
}
for (int i = 1; i <= 11; i++) {
  float fraction = i / 12.0; // Fraction du chemin entre le côté gauche et le côté droit de la base

  // Coordonnées interpolées pour la base du triangle du haut
  float interpTopX = lerp(-halfBaseWidth, halfBaseWidth, fraction);
  float interpTopY = yTop; // Y reste constant
  float interpTopZ = topZ;  // Z reste constant

  // Coordonnées interpolées pour la base du triangle du bas
  float interpBottomX = lerp(-halfBaseWidth, halfBaseWidth, fraction);
  float interpBottomY = yBottom; // Y reste constant
  float interpBottomZ = topZ;  // Z reste constant

  // Dessiner les lignes parallèles
  triangleSegment.vertex(interpTopX, interpTopY, interpTopZ);
  triangleSegment.vertex(interpBottomX, interpBottomY, interpBottomZ);
}
// Lignes verticales supplémentaires sur chaque triangle avec hauteurs variables
int numVerticalLines = 12; // Nombre de lignes verticales à ajouter
for (int i = 0; i <= numVerticalLines / 2; i++) {
    float fraction = i / (float) (numVerticalLines / 2);
    float interpX = lerp(-halfBaseWidth, 0, fraction);
    float currentTipZ = lerp(topZ, tipZ, fraction);  
    float nextFract= (i+1) / (float) (numVerticalLines / 2);
    float nextinterpX = lerp(-halfBaseWidth, 0, nextFract);
    float nextTipZ = lerp(topZ, tipZ, nextFract);
    
    triangleSegment.vertex(interpX, pylonWidth / 2, topZ);
    triangleSegment.vertex(interpX, pylonWidth / 2, currentTipZ);

    triangleSegment.vertex(interpX, -pylonWidth / 2, topZ);
    triangleSegment.vertex(interpX, -pylonWidth / 2, currentTipZ);
    
    triangleSegment.vertex(interpX, pylonWidth / 2, topZ);
    triangleSegment.vertex(interpX, -pylonWidth / 2, currentTipZ);
    
    triangleSegment.vertex(interpX, -pylonWidth / 2, topZ);
    triangleSegment.vertex(interpX, pylonWidth / 2, currentTipZ);
    if (i<6){
            
      triangleSegment.vertex(interpX, pylonWidth / 2, topZ);
      triangleSegment.vertex(nextinterpX, pylonWidth / 2, nextTipZ);
      
      triangleSegment.vertex(interpX, -pylonWidth / 2, topZ);
      triangleSegment.vertex(nextinterpX, -pylonWidth / 2, nextTipZ);
      
      triangleSegment.vertex(interpX, -pylonWidth / 2, currentTipZ);
      triangleSegment.vertex(nextinterpX, -pylonWidth / 2, topZ);
      
      triangleSegment.vertex(interpX, pylonWidth / 2, currentTipZ);
      triangleSegment.vertex(nextinterpX, pylonWidth / 2, topZ);
      
      triangleSegment.vertex(interpX, pylonWidth / 2, topZ);
      triangleSegment.vertex(nextinterpX, -pylonWidth / 2, topZ);
      
      triangleSegment.vertex(interpX, -pylonWidth / 2, topZ);
      triangleSegment.vertex(nextinterpX, pylonWidth / 2, topZ);
      
      triangleSegment.vertex(interpX, pylonWidth / 2, currentTipZ);
      triangleSegment.vertex(nextinterpX, -pylonWidth / 2, nextTipZ);
      
      triangleSegment.vertex(interpX, -pylonWidth / 2, currentTipZ);
      triangleSegment.vertex(nextinterpX, pylonWidth / 2, nextTipZ);
      
      
      
      
    }
    
}

for (int i = 0; i <= numVerticalLines / 2; i++) {
    float fraction = i / (float) (numVerticalLines / 2);
    float interpX = lerp(0, halfBaseWidth, fraction);
    float currentTipZ = lerp(tipZ, topZ, fraction);
    float nextFract = (i + 1) / (float) (numVerticalLines / 2);
    float nextInterpX = lerp(0, halfBaseWidth, nextFract);
    float nextTipZ = lerp(tipZ, topZ, nextFract);

    triangleSegment.vertex(interpX, pylonWidth / 2, topZ);
    triangleSegment.vertex(interpX, pylonWidth / 2, currentTipZ);

    triangleSegment.vertex(interpX, -pylonWidth / 2, topZ);
    triangleSegment.vertex(interpX, -pylonWidth / 2, currentTipZ);
    
    triangleSegment.vertex(interpX, pylonWidth / 2, topZ);
    triangleSegment.vertex(interpX, -pylonWidth / 2, currentTipZ);
    
    triangleSegment.vertex(interpX, -pylonWidth / 2, topZ);
    triangleSegment.vertex(interpX, pylonWidth / 2, currentTipZ);
    
    if (i < 6) {
        triangleSegment.vertex(interpX, pylonWidth / 2, topZ);
        triangleSegment.vertex(nextInterpX, pylonWidth / 2, nextTipZ);
        
        triangleSegment.vertex(interpX, -pylonWidth / 2, topZ);
        triangleSegment.vertex(nextInterpX, -pylonWidth / 2, nextTipZ);
        
        triangleSegment.vertex(interpX, -pylonWidth / 2, currentTipZ);
        triangleSegment.vertex(nextInterpX, -pylonWidth / 2, topZ);
        
        triangleSegment.vertex(interpX, pylonWidth / 2, currentTipZ);
        triangleSegment.vertex(nextInterpX, pylonWidth / 2, topZ);
        
        triangleSegment.vertex(interpX, pylonWidth / 2, topZ);
        triangleSegment.vertex(nextInterpX, -pylonWidth / 2, topZ);
        
        triangleSegment.vertex(interpX, -pylonWidth / 2, topZ);
        triangleSegment.vertex(nextInterpX, pylonWidth / 2, topZ);
        
        triangleSegment.vertex(interpX, pylonWidth / 2, currentTipZ);
        triangleSegment.vertex(nextInterpX, -pylonWidth / 2, nextTipZ);
        
        triangleSegment.vertex(interpX, -pylonWidth / 2, currentTipZ);
        triangleSegment.vertex(nextInterpX, pylonWidth / 2, nextTipZ);
    }
}
  
  triangleSegment.endShape();
  p.addChild(triangleSegment);
  // Calcul de la position centrale pour les ailes
  float midZ = pylonHeight*13/16; // Position z au milieu du pylône
  float wingSpan = pylonHeight/3; // Envergure de chaque aile
  
  // Ajouter des triangles comme des ailes au milieu
  PShape leftWing = createShape();
  leftWing.beginShape(TRIANGLES);
  leftWing.noFill();
  leftWing.strokeWeight(1);
  leftWing.stroke(0, 0, 0); // Couleur rouge pour distinguer
  // Coordonnées pour l'aile gauche
  leftWing.vertex(-pylonWidth / 2, pylonWidth / 2 , midZ);
  leftWing.vertex(-pylonWidth / 2 , pylonWidth / 2, midZ+pylonWidth);
  leftWing.vertex(-pylonWidth / 2 - wingSpan, pylonWidth / 2, midZ);
  leftWing.vertex(-pylonWidth / 2, -pylonWidth / 2, midZ);
  leftWing.vertex(-pylonWidth / 2 , -pylonWidth / 2, midZ+pylonWidth);
  leftWing.vertex(-pylonWidth / 2 - wingSpan, -pylonWidth / 2, midZ);
  for (int i = 0; i <= numVerticalLines / 2; i++) {
    topZ=pylonHeight*13/16;
    tipZ=topZ+pylonWidth;
    halfBaseWidth=wingSpan;
    float fraction = i / (float) (numVerticalLines / 2);
    float interpX = lerp(pylonWidth/2, halfBaseWidth+pylonWidth/2, fraction);
    float currentTipZ = lerp(tipZ, topZ, fraction);
    float nextFract = (i + 1) / (float) (numVerticalLines / 2);
    float nextInterpX = lerp(pylonWidth/2, halfBaseWidth+pylonWidth/2, nextFract);
    float nextTipZ = lerp(tipZ, topZ, nextFract);

    leftWing.vertex(interpX, pylonWidth / 2, topZ);
    leftWing.vertex(interpX, pylonWidth / 2, currentTipZ);

    leftWing.vertex(interpX, -pylonWidth / 2, topZ);
    leftWing.vertex(interpX, -pylonWidth / 2, currentTipZ);
    
    leftWing.vertex(interpX, pylonWidth / 2, topZ);
    leftWing.vertex(interpX, -pylonWidth / 2, currentTipZ);
    
    leftWing.vertex(interpX, -pylonWidth / 2, topZ);
    leftWing.vertex(interpX, pylonWidth / 2, currentTipZ);
    
    if (i < 6) {
        leftWing.vertex(interpX, pylonWidth / 2, topZ);
        leftWing.vertex(nextInterpX, pylonWidth / 2, nextTipZ);
        
        leftWing.vertex(interpX, -pylonWidth / 2, topZ);
        leftWing.vertex(nextInterpX, -pylonWidth / 2, nextTipZ);
        
        leftWing.vertex(interpX, -pylonWidth / 2, currentTipZ);
        leftWing.vertex(nextInterpX, -pylonWidth / 2, topZ);
        
        leftWing.vertex(interpX, pylonWidth / 2, currentTipZ);
        leftWing.vertex(nextInterpX, pylonWidth / 2, topZ);
        
        leftWing.vertex(interpX, pylonWidth / 2, topZ);
        leftWing.vertex(nextInterpX, -pylonWidth / 2, topZ);
        
        leftWing.vertex(interpX, -pylonWidth / 2, topZ);
        leftWing.vertex(nextInterpX, pylonWidth / 2, topZ);
        
        leftWing.vertex(interpX, pylonWidth / 2, currentTipZ);
        leftWing.vertex(nextInterpX, -pylonWidth / 2, nextTipZ);
        
        leftWing.vertex(interpX, -pylonWidth / 2, currentTipZ);
        leftWing.vertex(nextInterpX, pylonWidth / 2, nextTipZ);
    }
}
  leftWing.endShape(CLOSE);
  
  PShape rightWing = createShape();
  rightWing.beginShape(TRIANGLES);
  rightWing.noFill();
  rightWing.strokeWeight(1);
  rightWing.stroke(0, 0, 0); // Couleur bleue pour distinguer
  // Coordonnées pour l'aile droite
  rightWing.vertex(pylonWidth / 2, pylonWidth / 2 , midZ);
  rightWing.vertex(pylonWidth / 2 , pylonWidth / 2, midZ+pylonWidth);
  rightWing.vertex(pylonWidth / 2 + wingSpan, pylonWidth / 2, midZ);
  rightWing.vertex(pylonWidth / 2, -pylonWidth / 2, midZ);
  rightWing.vertex(pylonWidth / 2 , -pylonWidth / 2, midZ+pylonWidth);
  rightWing.vertex(pylonWidth / 2 + wingSpan, -pylonWidth / 2, midZ);
  numVerticalLines = 12; // Nombre de lignes verticales à ajouter
for (int i = 0; i <= numVerticalLines / 2; i++) {
    topZ=pylonHeight*13/16;
    tipZ=topZ+pylonWidth;
    halfBaseWidth=wingSpan;
    float fraction = i / (float) (numVerticalLines / 2);
    float interpX = lerp(-halfBaseWidth-pylonWidth/2, -pylonWidth/2, fraction);
    float currentTipZ = lerp(topZ, tipZ, fraction);
    float nextFract= (i+1) / (float) (numVerticalLines / 2);
    float nextinterpX = lerp(-halfBaseWidth-pylonWidth/2, -pylonWidth/2, nextFract);
    float nextTipZ = lerp(topZ, tipZ, nextFract);
    
    rightWing.vertex(interpX, pylonWidth / 2, topZ);
    rightWing.vertex(interpX, pylonWidth / 2, currentTipZ);

    rightWing.vertex(interpX, -pylonWidth / 2, topZ);
    rightWing.vertex(interpX, -pylonWidth / 2, currentTipZ);
    
    rightWing.vertex(interpX, pylonWidth / 2, topZ);
    rightWing.vertex(interpX, -pylonWidth / 2, currentTipZ);
    
    rightWing.vertex(interpX, -pylonWidth / 2, topZ);
    rightWing.vertex(interpX, pylonWidth / 2, currentTipZ);
    if (i<6){
            
      rightWing.vertex(interpX, pylonWidth / 2, topZ);
      rightWing.vertex(nextinterpX, pylonWidth / 2, nextTipZ);
      
      rightWing.vertex(interpX, -pylonWidth / 2, topZ);
      rightWing.vertex(nextinterpX, -pylonWidth / 2, nextTipZ);
      
      rightWing.vertex(interpX, -pylonWidth / 2, currentTipZ);
      rightWing.vertex(nextinterpX, -pylonWidth / 2, topZ);
      
      rightWing.vertex(interpX, pylonWidth / 2, currentTipZ);
      rightWing.vertex(nextinterpX, pylonWidth / 2, topZ);
      
      rightWing.vertex(interpX, pylonWidth / 2, topZ);
      rightWing.vertex(nextinterpX, -pylonWidth / 2, topZ);
      
      rightWing.vertex(interpX, -pylonWidth / 2, topZ);
      rightWing.vertex(nextinterpX, pylonWidth / 2, topZ);
      
      rightWing.vertex(interpX, pylonWidth / 2, currentTipZ);
      rightWing.vertex(nextinterpX, -pylonWidth / 2, nextTipZ);
      
      rightWing.vertex(interpX, -pylonWidth / 2, currentTipZ);
      rightWing.vertex(nextinterpX, pylonWidth / 2, nextTipZ);
      
      
    }
    
}
  rightWing.endShape(CLOSE);
  
  // Ajouter les ailes au groupe principal
  p.addChild(leftWing);
  p.addChild(rightWing);

  // Rotation autour des axes X et Y pour créer des pylônes supplémentaires
  PShape rotatedPylonX = createShape();
  rotatedPylonX.addChild(p);
  rotatedPylonX.rotateX(HALF_PI);

  PShape rotatedPylonY = createShape();
  rotatedPylonY.addChild(p);
  rotatedPylonY.rotateY(HALF_PI);

  // Créer un groupe contenant les trois pylônes
  PShape combinedPylons = createShape(GROUP);
  combinedPylons.addChild(p);
  combinedPylons.addChild(rotatedPylonX);
  combinedPylons.addChild(rotatedPylonY);
  //combinedPylons.rotateZ(PI/2);


  return combinedPylons; // Retourner les pylônes combinés comme une seule forme PShape
}
void placeObjects(PShape pylon, float x1, float y1, float x2, float y2, float numObjects, PShape terrain) {
    // Calculer le vecteur directeur entre les deux points
    float dx = x2 - x1;
    float dy = y2 - y1;
    
    // Calculer la distance entre les deux points
    float distance = sqrt(dx * dx + dy * dy);
    
    // Calculer l'incrément pour chaque objet
    float increment = distance / (numObjects + 1);
  
    // Placer les pylones et dessiner les câbles entre eux
    for (int i = 1; i <= numObjects; i++) {
        float prevX = x1 + (i - 1) * increment * (dx / distance);
        float prevY = y1 + (i - 1) * increment * (dy / distance);
        float prevZ = findAltitude(prevX, prevY, terrain);
        float cableStartZ = prevZ + pylonHeight * 13 / 16; // Altitude de départ des câbles pour le pylône précédent
        
        // Calculer les coordonnées du pylône actuel
        float x = x1 + i * increment * (dx / distance);
        float y = y1 + i * increment * (dy / distance);
        float z = findAltitude(x, y, terrain);
        float currentCableStartZ = z + pylonHeight * 13 / 16; // Altitude de départ des câbles pour le pylône actuel
        
        // Dessiner le pylône à la position (x, y, z)
        pushMatrix();
        translate(x, y, z);
        shape(pylon);
        
        popMatrix();

        // Dessiner les câbles entre ce pylône et le précédent (s'il y en a un)
        if( doCables ){
          if (i > 1 ) {
              // Dessiner le câble
              noFill();
              stroke(0); // Couleur du câble (noir)
              float curvature = 3; // Ajuster ce facteur selon vos besoins
              float diffAlt=(abs(currentCableStartZ-cableStartZ))/3 ;
              // Dessiner le câble avec une courbure plus prononcée pour les grandes distances
              bezier(
                  x+pylonHeight/3, y-pylonWidth/2, currentCableStartZ,          // Point de départ (au-dessus du pylône actuel)
                  x+pylonHeight/3, y-3, z+curvature-diffAlt,               // Premier point de contrôle (curvé vers le bas)
                  prevX+pylonHeight/3, prevY+3, prevZ+curvature-diffAlt,   // Deuxième point de contrôle (curvé vers le bas)
                  prevX+pylonHeight/3, prevY+pylonWidth/2, cableStartZ          // Point d'arrivée (au-dessus du pylône précédent)
              );
              bezier(
                  x-pylonHeight/3, y-pylonWidth/2, currentCableStartZ,          // Point de départ (au-dessus du pylône actuel)
                  x-pylonHeight/3, y-3, z+curvature-diffAlt,               // Premier point de contrôle (curvé vers le bas)
                  prevX-pylonHeight/3, prevY+3, prevZ+curvature-diffAlt,   // Deuxième point de contrôle (curvé vers le bas)
                  prevX-pylonHeight/3, prevY+pylonWidth/2, cableStartZ          // Point d'arrivée (au-dessus du pylône précédent)
              );
              
              bezier(
                  x-pylonHeight/4, y-pylonWidth/2, currentCableStartZ,          // Point de départ (au-dessus du pylône actuel)
                  x-pylonHeight/4, y-3, z+curvature-diffAlt,               // Premier point de contrôle (curvé vers le bas)
                  prevX-pylonHeight/4, prevY+3, prevZ+curvature-diffAlt,   // Deuxième point de contrôle (curvé vers le bas)
                  prevX-pylonHeight/4, prevY+pylonWidth/2, cableStartZ          // Point d'arrivée (au-dessus du pylône précédent)
              );
              bezier(
                  x+pylonHeight/4, y-pylonWidth/2, currentCableStartZ,          // Point de départ (au-dessus du pylône actuel)
                  x+pylonHeight/4, y-3, z+curvature-diffAlt,               // Premier point de contrôle (curvé vers le bas)
                  prevX+pylonHeight/4, prevY+3, prevZ+curvature-diffAlt,   // Deuxième point de contrôle (curvé vers le bas)
                  prevX+pylonHeight/4, prevY+pylonWidth/2, cableStartZ          // Point d'arrivée (au-dessus du pylône précédent)
              );
              bezier(
                  x-pylonHeight/6, y-pylonWidth/2, currentCableStartZ,          // Point de départ (au-dessus du pylône actuel)
                  x-pylonHeight/6, y-3, z+curvature-diffAlt,               // Premier point de contrôle (curvé vers le bas)
                  prevX-pylonHeight/6, prevY+3, prevZ+curvature-diffAlt,   // Deuxième point de contrôle (curvé vers le bas)
                  prevX-pylonHeight/6, prevY+pylonWidth/2, cableStartZ          // Point d'arrivée (au-dessus du pylône précédent)
              );
              bezier(
                  x+pylonHeight/6, y-pylonWidth/2, currentCableStartZ,          // Point de départ (au-dessus du pylône actuel)
                  x+pylonHeight/6, y-3, z+curvature-diffAlt,               // Premier point de contrôle (curvé vers le bas)
                  prevX+pylonHeight/6, prevY+3, prevZ+curvature-diffAlt,   // Deuxième point de contrôle (curvé vers le bas)
                  prevX+pylonHeight/6, prevY+pylonWidth/2, cableStartZ          // Point d'arrivée (au-dessus du pylône précédent)
              );
              bezier(
                  x-pylonHeight/20, y-pylonWidth/2, currentCableStartZ,          // Point de départ (au-dessus du pylône actuel)
                  x-pylonHeight/20, y-3, z+curvature-diffAlt,               // Premier point de contrôle (curvé vers le bas)
                  prevX-pylonHeight/20, prevY+3, prevZ+curvature-diffAlt,   // Deuxième point de contrôle (curvé vers le bas)
                  prevX-pylonHeight/20, prevY+pylonWidth/2, cableStartZ          // Point d'arrivée (au-dessus du pylône précédent)
              );
              bezier(
                  x+pylonHeight/20, y-pylonWidth/2, currentCableStartZ,          // Point de départ (au-dessus du pylône actuel)
                  x+pylonHeight/20, y-3, z+curvature-diffAlt,               // Premier point de contrôle (curvé vers le bas)
                  prevX+pylonHeight/20, prevY+3, prevZ+curvature-diffAlt,   // Deuxième point de contrôle (curvé vers le bas)
                  prevX+pylonHeight/20, prevY+pylonWidth/2, cableStartZ          // Point d'arrivée (au-dessus du pylône précédent)
              );
          }
        }
    }
}
