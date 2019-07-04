public class Title implements Scene {
  public void update() {
    if (Input.buttonA())
      SceneManager.setScene(new Stage("original"));
  }
  
  public void draw() {
    background(0);
  }
}
