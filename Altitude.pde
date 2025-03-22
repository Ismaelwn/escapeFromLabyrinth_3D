float findAltitude(float x, float y, PShape terrain) {
  float closestZ = Float.MAX_VALUE; // Initialiserl'altitude la plus proche à une valeur maximale
  float closestDist = Float.MAX_VALUE; // Initialiser la distance la plus proche à une valeur maximale
  int numChildren = terrain.getChildCount();
  
  // Parcourir tous les sous-éléments (faces) du modèle du terrain
  for (int i = 0; i < numChildren; i++) {
    PShape child = terrain.getChild(i);
    int numVertices = child.getVertexCount();
    
    // Parcourir tous les points de la face
    for (int j = 0; j < numVertices; j++) {
      PVector vertex = child.getVertex(j);
      float dist = dist(x, y, vertex.x, vertex.y); // Calculer la distance euclidienne
      
      // Si la distance de ce point est plus proche que celle précédemment trouvée
      if (dist < closestDist) {
        closestDist = dist;
        closestZ = vertex.z; // Mettre à jour l'altitude la plus proche
      }
    }
  }
  
  return closestZ; // Retourner l'altitude la plus proche
}
