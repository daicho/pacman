// ルール説明画面
public class Rule implements Scene {
  public void update() {
    if (Input.buttonAPress())
      SceneManager.setScene(new Game(3));
  }

  public void draw() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(font, 20);
    text("Rule\nPress 'Z' Key", SCREEN_SIZE.x / 2, 150);
  }
}
