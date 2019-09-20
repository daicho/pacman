class Game implements Scene {
   protected Stage stage = new Stage("original");
   
   public void update() {
     stage.update();
   }
   
   public void draw() {
     stage.draw();
   }
}
