void placeEol(PShape shape, float x1, float y1, float x2, float y2, PShape terrain) {
    // Calculer le point central entre les deux points
    float cx = (x1 + x2) / 2;
    float cy = (y1 + y2) / 2;

    // Rayon du cercle circonscrit au triangle équilatéral
    float distance = dist(x1, y1, x2, y2) / 2;
    float radius = (distance / sqrt(3)) * 0.6;  
    // Angles pour positionner les éoliennes
    float[] angles = new float[]{PI / 6, 5 * PI / 6, 3 * PI / 2};  // 30°, 150°, 270° pour un placement uniforme
    
    // Placer les trois éoliennes
    for (int i = 0; i < 3; i++) {
        // Calculer les coordonnées x, y pour chaque éolienne
        float x = cx + radius * cos(angles[i]);
        float y = cy + radius * sin(angles[i]);
        
        // Trouver la coordonnée z correspondante sur le modèle de terrain
        float z = findAltitude(x, y, terrain);
        
        // Dessiner l'éolienne à la position (x, y, z)
        pushMatrix();
        translate(x, y, z);
        //scale(2);  // Adapter la taille de l'éolienne si nécessaire
        shape(shape);
        popMatrix();
    }
}
