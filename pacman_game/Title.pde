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
    text("Title\nPress 'Z' Key", width / 2, 150);
    text("Rank", width / 2, 200);
    for(int i = 0; i < 10; i++){
      text(Record.highScore[i], width / 2, 230+i*20);
    }
  }
}