public class Title implements Scene {
  public void update() {
    if (Input.buttonA())
      SceneManager.setScene(new Stage("original"));
  }

  public void draw() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(font, 20);
    text("Title\nPress 'Z' Key", width / 2, height / 2);
  }
}
