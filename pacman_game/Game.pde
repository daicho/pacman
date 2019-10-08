// ゲーム画面
class Game implements Scene {
  protected int life;          // 残機の数
  protected int score = 0;     // 現在のスコア
  protected int prevScore = 0; // 前ステージまでのスコア

  protected String[] stageNames = {"1", "2", "3"}; // ステージ名
  protected int stageNum = 0; // 現在のステージ番号
  protected Stage stage;      // 現在のステージ

  public Game(int life) {
    this.life = life - 1;
    this.stage = new Stage(stageNames[stageNum]);
  }

  public void update() {
    stage.update();

    switch (stage.getStatus()) {
    case Finish:
      // 次のステージへ
      stageNum++;

      if (stageNum >= stageNames.length)
        SceneManager.setScene(new Result(score, stageNum + 1, true));
      else
        this.stage = new Stage(stageNames[stageNum]);

      break;

    case Reset:
      // ゲームオーバー
      if (life <= 0)
        SceneManager.setScene(new Result(score, stageNum + 1, false));
      life--;

      break;

    default:
      break;
    }
  }

  public void draw() {
    stage.draw();
    this.score = prevScore + stage.getScore();

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
