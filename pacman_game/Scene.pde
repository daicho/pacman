// シーン
public interface Scene {
  public void update();
  public void draw();
}

// シーン管理
public static class SceneManager {
  protected static Scene scene;

  public static void setScene(Scene scene) {
    SceneManager.scene = scene;
  }

  public static void update() {
    scene.update();
  }

  public static void draw() {
    scene.draw();
  }
}

// タイトル画面
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
    for (int i = 0; i < 10; i++) {
      text(Record.highScore[i], width / 2, 230+i*20);
    }
  }
}

// リザルト画面
public class Result implements Scene {
  protected int score;

  public Result(int score) {
    this.score = score;
    // ハイスコア更新処理
    if (Record.getRankScore(-1) < this.score) {
      Record.setRankScore(this.score);
      Record.saveRankScore();
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
