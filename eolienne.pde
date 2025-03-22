PShape p ;
GeneratorE e;

interface Resize{
  void resizable(float value);
  void update();
}
class Holder implements Resize {
  private PShape p;
  public float lb = 60;  // Rayon de la base du cylindre
  public float topRadius = 20;   // Rayon du haut du cylindre
  public float h = 2000;    // Hauteur du cylindre
  
  public Holder() {
    update();
  }

  // Méthode pour redimensionner le cylindre
  public void resizable(float rate) {
    lb *= rate;
    topRadius *= rate;
    h *= rate;
    update();
  }

  // Méthode pour mettre à jour le PShape avec un nouveau cylindre
  public void update() {
    p = createShape();
    
   
    p.beginShape(PConstants.QUAD_STRIP);
    p.fill(240);
    p.noStroke();
    float angleStep = PConstants.TWO_PI / 36;  // Nombre de côtés du cylindre (plus il y a de côtés, plus le cylindre est lisse)
    for (float angle = 0; angle < PConstants.TWO_PI; angle += angleStep) {
      float x = cos(angle);
      float y = sin(angle);
      // Créer les côtés du cylindre
      p.vertex(x * lb, y * lb, 0);
      p.vertex(x * topRadius, y * topRadius, h);
    }
    // Compléter le cylindre en reliant le dernier point au premier
    p.vertex(lb, 0, 0);
    p.vertex(topRadius, 0, h);
    p.endShape();
  }

  public PShape getShape() {
    return p;
  }
}


class Wing implements Resize{
  PShape p;
  private float r;
  public Wing(){
    r=1;
    update();
  }
  
  public void resizable(float rate){
    r=rate;
    update();
  }
  
  public PShape getShape(){return p;}
  
  public void update(){
    p=createShape();
    p.beginShape();
      p.vertex(0, 0, 0);
      p.bezierVertex(-5*r, 5*r, 70*r, -10*r, 10*r, 60*r , -20*r, 10*r, 50*r);
      p.bezierVertex(-30*r, 15*r, 40*r, -40*r, 25*r, 50*r , -50*r, 20*r, 70*r);
      p.quadraticVertex(-45*r, -5*r, 250*r, -40*r, -10*r, 400*r);
      p.vertex(-40*r, -20*r, 400*r);
      p.bezierVertex(-35*r, -22*r, 400*r, -30*r, -25*r, 390*r, -20*r, -30*r, 70*r);
      p.quadraticVertex(-10*r, -25*r, 50*r, 0*r, -10*r, 0*r);
    p.endShape();
  }
}

class Head implements Resize{
  PShape p;
  public float hhead=80, rhead=50, c2=0.1, c3=hhead/20.0, c4=10.0, hhead2=40, c5=0.2, c6=0.4, tempX, tempY;
  public Head(){
    update();
  }
  
  public void resizable(float r){
    hhead*=r;
    rhead*=r;
    c2*=r;
    c3*=r;
    c4*=r;
    hhead2*=r;
    c5*=r;
    c6*=r;
    update();
  }
  
  public PShape getShape(){return p;}
  
  public void update(){
      p=createShape();
    p.beginShape();
    for(int i = 0; i < 50; i++){
      p.vertex(0, 0, 0);
      tempX=rhead * cos(2 * i * PI/50.0);
      tempY=rhead * sin(2 * i * PI/50.0);
      p.quadraticVertex(tempX/c4, tempY/c4, 0, tempX/2.0, tempY/2.0, hhead/2.0);
      float xt2=0.6*tempX, yt2=0.6*tempY;
      p.bezierVertex(xt2, yt2, 0.5*hhead, xt2, yt2, 0.57*hhead, xt2*0.8, yt2*0.8, 0.6*hhead);
      p.vertex(xt2*0.2, yt2*0.2, 0.6*hhead);
      xt2=0.8*tempX;
      yt2=0.8*tempY;
      p.vertex(xt2*0.2, yt2*0.2, 0.8*hhead);
       xt2=0.9*tempX;
      yt2=0.9*tempY;
      p.bezierVertex(xt2*0.9, yt2*0.9, 0.85*hhead, xt2*0.8, yt2*0.8, 0.87*hhead, xt2, yt2, 0.9*hhead);
      p.bezierVertex(tempX*(1+c2), tempY*(1+c2), hhead-c3, tempX*(1+c2*0.75), tempY*(1+0.75*c2) , hhead-0.75*c3,  tempX, tempY, hhead);
     
      p.bezierVertex(tempX*(1-c6), tempY*(1-c6), hhead, tempX*c5*0.8, tempY*c5*0.8 , hhead+hhead2,  0, 0, hhead+hhead2);
   
    }
    p.endShape();
  }
}



public class GeneratorE implements Resize{
  PShape shape;
  Holder holder;
  Wing wing0, wing1, wing2, wing3;
  Head head;
  
  public GeneratorE(){
    shape=createShape();
    holder= new Holder();
    PShape pholder=holder.getShape();
    
    head = new Head();
    PShape phead=head.getShape();
    phead.rotateY(PI/2);
    phead.translate(-0.3*head.hhead+holder.lb/2, holder.lb/2, holder.h);
    
    wing0 = new Wing();
    PShape pwing0=wing0.getShape();
    pwing0.translate(head.hhead * 0.7+holder.lb/2, holder.lb/2, head.tempX*0.2+holder.h);
    
    wing1 = new Wing();
    PShape pwing1=wing1.getShape();
    pwing1.rotateX(PI/2);
    pwing1.translate(head.hhead * 0.7+holder.lb/2, holder.lb/2, head.tempX*0.2+holder.h);
    
    wing2 = new Wing();
    PShape pwing2=wing2.getShape();
    pwing2.rotateX(PI);
    pwing2.translate(head.hhead * 0.7+holder.lb/2, holder.lb/2, head.tempX*0.2+holder.h);
    
    wing3 = new Wing();
    PShape pwing3=wing3.getShape(); 
    pwing3.rotateX(-PI/2);
    pwing3.translate(head.hhead * 0.7+holder.lb/2, holder.lb/2, head.tempX*0.2+holder.h);
    
    shape=createShape(GROUP);
    shape.addChild(phead);
    shape.addChild(pholder);
    shape.addChild(pwing0);
    shape.addChild(pwing1);
    shape.addChild(pwing2);
    shape.addChild(pwing3);
  }
   
  public void animate(float anim){
    wing0.getShape().translate(-holder.lb/2, -holder.lb/2, -holder.h);
    wing0.getShape().rotateX(anim);
    wing0.getShape().translate(holder.lb/2, holder.lb/2, holder.h);
    
    wing1.getShape().translate(-holder.lb/2, -holder.lb/2, -holder.h);
    wing1.getShape().rotateX(anim);
    wing1.getShape().translate(holder.lb/2, holder.lb/2, holder.h);
    
    wing2.getShape().translate(-holder.lb/2, -holder.lb/2, -holder.h);
    wing2.getShape().rotateX(anim);
    wing2.getShape().translate(holder.lb/2, holder.lb/2, holder.h);
    
    wing3.getShape().translate(-holder.lb/2, -holder.lb/2, -holder.h);
    wing3.getShape().rotateX(anim);
    wing3.getShape().translate(holder.lb/2, holder.lb/2, holder.h);
  }
  public PShape getShape(){return shape;}
  public void resizable(float r){
    holder.resizable(r);
    wing0.resizable(r);
    wing1.resizable(r);
    wing2.resizable(r);
    wing3.resizable(r);
    head.resizable(r);
    update();
  }
  
  public void update(){
    PShape pholder=holder.getShape();
    
    PShape phead=head.getShape();
    phead.rotateY(PI/2);
    phead.translate(-0.3*head.hhead+holder.lb/2, holder.lb/2, holder.h);
    
    PShape pwing0=wing0.getShape();
    pwing0.translate(head.hhead * 0.7+holder.lb/2, holder.lb/2, head.tempX*0.2+holder.h);
    
    PShape pwing1=wing1.getShape();
    pwing1.rotateX(PI/2);
    pwing1.translate(head.hhead * 0.7+holder.lb/2, holder.lb/2, head.tempX*0.2+holder.h);
    
    PShape pwing2=wing2.getShape();
    pwing2.rotateX(PI);
    pwing2.translate(head.hhead * 0.7+holder.lb/2, holder.lb/2, head.tempX*0.2+holder.h);

    PShape pwing3=wing3.getShape(); 
    pwing3.rotateX(-PI/2);
    pwing3.translate(head.hhead * 0.7+holder.lb/2, holder.lb/2, head.tempX*0.2+holder.h);
    
    shape=createShape(GROUP);
    //shape.addChild(head.getShape());
    shape.addChild(holder.getShape());
    shape.addChild(wing0.getShape());
    shape.addChild(wing1.getShape());
    shape.addChild(wing2.getShape());
    shape.addChild(wing3.getShape());
  }
}
