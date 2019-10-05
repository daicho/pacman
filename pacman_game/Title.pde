// タイトル画面
public class Title implements Scene {
  public void update() {
    if (Input.buttonAPress())
      SceneManager.setScene(new Rule());
  }

  public void draw() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(font, 20);
    text("Title\nPress 'Z' Key", SCREEN_SIZE.x / 2, 150);
    text("Ranking", SCREEN_SIZE.x / 2, 200);
    for (int i = 0; i < 10; i++)
      text(Record.getRanking(i + 1), SCREEN_SIZE.x / 2, 230 + i * 20);
  }
}
