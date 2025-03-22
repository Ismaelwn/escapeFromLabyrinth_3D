float fov = PI/3.0;
float cameraZ;
void adjustFOV(boolean zoomIn) {
    float zoomAmount = 0.1; // Régler ce montant pour un contrôle plus fin ou plus grossier
    if (zoomIn && fov > 0.1) { // Empêcher le FOV de devenir trop petit
        fov -= zoomAmount;
    } else if (!zoomIn && fov < PI) { // Empêcher le FOV de devenir trop grand
        fov += zoomAmount;
    }
    float newCameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), 1, cameraZ*10.0);
    camera(xCam, yCam, newCameraZ, targetX, targetY, targetZ, 0, 1, 0);
}
void keyPressed() {
  
  // zoomer
  if (keyCode == 38){
        
   
      zCam -= 2;
    
  }
  // dezoomer
  if (keyCode == 40){
     zCam += 2;
  }
  // gauche
   if (keyCode == 37){
     xCam += 2;
  }
  if (keyCode == 75){
     adjustFOV(true);
  }
  if (keyCode == 76){
     adjustFOV(false);
  }
  
  //print (keyCode);
  // touche a 
  if (keyCode == 81){
     xCam -= 2;
  }
  
  // droite
  if (keyCode == 39){
     xCam -= 10;
  }
  
  // touche z
  if (keyCode == 87){
     yCam -= 10;
  }
  
  if( keyCode  == 79 ){ // Ajouter/retirer les eoliennes
    if(doEoliennes) doEoliennes = false ;
    else doEoliennes = true ;
  }
  
  if( keyCode  == 80 ){ // Ajouter/retirer les Pylons 
    if(doPylons) doPylons = false ;
    else doPylons = true ;
  }
  
  if( keyCode  == 73 ){ // Ajouter/retirer les cables
    if(doCables) doCables = false ;
    else doCables = true ;
  }
  
    
  
}
