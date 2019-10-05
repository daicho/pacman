// ゲーム画面
class Game implements Scene {
  protected int life;      // 残機の数
  protected int score = 0;     // 現在のスコア
  protected int prevScore = 0; // 前ステージまでのスコア
  protected int curStage = 0;  // 現在のステージ

  // ステージ
  protected Stage[] stages = {
    new Stage("1"), 
    new Stage("2"), 
    new Stage("3")
  };

  public Game(int life) {
    this.life = life - 1;
  }

  public void update() {
    stages[curStage].update();

    switch (stages[curStage].getStatus()) {
    case Finish:
      curStage++;
      if (curStage >= stages.length)
        SceneManager.setScene(new Result(score));
      break;

    case Reset:
      if (life <= 0)
        SceneManager.setScene(new Result(score));
      life--;
      break;

    default:
      break;
    }
  }

  public void draw() {
    stages[curStage].draw();
    this.score = prevScore + stages[curStage].getScore();

    // スコア表示
    fill(255);
    textAlign(RIGHT, BASELINE);
    textFont(font, 20);
    text("SCORE", 75, 140);
    text(score, 75, 160);
    text("HiSCORE", 465, 140);
    if (Record.getRanking(1) > score)
      text(Record.getRanking(1), 445, 160);
    else
      text(score, 445, 160);
  }
}
