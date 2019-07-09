public class Result implements Scene {
  protected int score;

  public Result(int score) {
    this.score = score;
    // ハイスコア更新処理
    if (Record.getHighScore() < this.score) {
      Record.setHighScore(this.score);
      Record.saveHighScore();
    }
  }

  public void update() {
    if (Input.buttonA())
      SceneManager.setScene(new Title());
  }

  public void draw() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(font, 20);
    text("Result\nScore:" + score + "\nPress 'Z' Key", width / 2, height / 2);
  }
}