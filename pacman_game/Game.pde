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

  public int getScore() {
    return score;
  }

  public void update() {
    stages[curStage].update();

    switch (stages[curStage].getStatus()) {
    case Finish:
      curStage++;
      if (curStage >= stages.length)
        SceneManager.setScene(new Result(score));

    case Reset:
      if (life <= 0)
        SceneManager.setScene(new Result(score));
      life--;

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
    text("SCORE", 75, 180);
    text(score, 75, 200);
    text("HiSCORE", 465, 180);
    if (Record.getRanking(1) > score)
      text(Record.getRanking(1), 445, 200);
    else
      text(score, 445, 200);
  }
}
