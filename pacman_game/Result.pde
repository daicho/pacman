// リザルト画面
public class Result implements Scene {
  protected int score;     // スコア
  protected int stage;     // ステージ
  protected boolean clear; // クリアしたか
  protected int ranking;   // ランキング
  protected boolean light = true; // 点灯中か
  protected Timer lightTimer = new Timer(30); // タイマー
  
  // キャラクター
  protected FreeCharacter[] characters = {
    new FreeCharacter(new PVector(292, 765), 3, 0, "pacman"),
    new FreeCharacter(new PVector(328, 765), 3, 0, "akabei"),
    new FreeCharacter(new PVector(364, 765), 3, 0, "aosuke"),
    new FreeCharacter(new PVector(400, 765), 3, 0, "pinky"),
    new FreeCharacter(new PVector(436, 765), 3, 0, "ohya")
  };

  public Result(int score, int stage, boolean clear) {
    this.score = score;
    this.stage = stage;
    this.clear = clear;

    // ハイスコア更新処理
    if (Record.getRanking(-1) < this.score) {
      ranking = Record.setRanking(this.score);
      Record.saveRanking();
    }
  }

  public void update() {
    if (lightTimer.update()) {
      lightTimer.setTime(light ? 15 : 30);
      light = !light;
    }
    
    for (FreeCharacter character : characters)
      character.update();

    if (Input.buttonAPress())
      SceneManager.setScene(new Title());
  }

  public void draw() {
    background(200, 240, 255);
    noStroke();
    textAlign(CENTER, CENTER);
    
    fill(63, 63, 63);
    rect(SCREEN_SIZE.x / 2 - 210, 130, 420, 75);
    
    fill(255, 255, 255);
    textFont(font2, 60);
    if (clear)
      text("GAME CLEAR!", SCREEN_SIZE.x / 2, 163);
    else
      text("GAME OVER", SCREEN_SIZE.x / 2, 163);
      
    fill(0, 0, 0);
    text(stage, SCREEN_SIZE.x / 2, 333);
    text(score, SCREEN_SIZE.x / 2, 468);
      
    fill(0, 0, 159);
    textFont(font2, 40);
    text("ステージ", SCREEN_SIZE.x / 2, 283);
    text("スコア", SCREEN_SIZE.x / 2, 418);
    
    if (light && ranking != 0) {
      fill(127, 127, 127);
      rect(SCREEN_SIZE.x / 2 - 160, 550, 320, 60);

      fill(255, 255, 0);
      text("ランキングNo. " + ranking, SCREEN_SIZE.x / 2, 580);
    }
    
    fill(0, 0, 0);
    text("またあそんでね！", 340, 710);

    for (FreeCharacter character : characters)
      character.draw();
  }
}
