void placeObjects(PShape shape, float x1, float y1, float x2, float y2, int numObjects) {
    // Calculer le vecteur directeur entre les deux points
    float dx = x2 - x1;
    float dy = y2 - y1;
    
    // Calculer la distance entre les deux points
    float distance = sqrt(dx * dx + dy * dy);
    
    // Calculer l'incrément pour chaque objet
    float increment = distance / (numObjects + 1);
   
    // Placer les pylons et dessiner les câbles entre eux
    for (int i = 1; i <= numObjects; i++) {
        // Calculer les coordonnées du pylon actuel
        float x = x1 + i * increment * (dx / distance);
        float y = y1 + i * increment * (dy / distance);
        // Trouver la coordonnée z correspondante sur le modèle
        float z = findAltitude(x, y, terrain);
        
        // Dessiner le pylon à la position (x, y, z)
        pushMatrix();
        translate(x, y, z);
        scale(2);
        shape(pylon);
        popMatrix();

        // Dessiner les câbles entre ce pylon et le précédent (s'il y en a un)
        if (i > 1) { // On ne dessine des câbles que si ce n'est pas le premier pylon
            float prevX = x1 + (i - 1) * increment * (dx / distance);
            float prevY = y1 + (i - 1) * increment * (dy / distance);
            float prevZ = findAltitude(prevX, prevY, terrain);

            // Dessiner le câble
            noFill();
            stroke(0); // Couleur du câble (noir)
            
            // Calculer l'ampleur de la courbure en fonction de la distance
            float curvature = distance / 25; // Ajuster ce facteur selon vos besoins

            // Dessiner le câble avec une courbure plus prononcée pour les grandes distances
            bezier(
                x, y, z + 10,                   // Point de départ (au-dessus du pylon actuel)
                x, y, z + curvature,            // Premier point de contrôle (curvé vers le bas)
                prevX, prevY, prevZ + curvature, // Deuxième point de contrôle (curvé vers le bas)
                prevX, prevY, prevZ + 10        // Point d'arrivée (au-dessus du pylon précédent)
            );
        }
    }
}
