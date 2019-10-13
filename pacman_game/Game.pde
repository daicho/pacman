// ゲーム画面
public class Game implements Scene {
  public static final int LIFE_NUM = 3;
  public static final int ONEUP_SCORE = 10000;
  
  protected int life = LIFE_NUM - 1; // 残機の数
  protected int score = 0;           // 現在のスコア
  protected int prevScore = 0;       // 前ステージまでのスコア
  protected int nextOneUpScore = ONEUP_SCORE; // 1UPするスコア

  protected String[] stageNames = {"1", "2", "3"}; // ステージ名
  protected int stageNum = 0; // 現在のステージ番号
  protected Stage stage;      // 現在のステージ

  protected PImage lifeImage = loadImage("images/player-3-0.png"); // 残基の画像
  protected SoundEffect se = new SoundEffect(minim); // SE

  // ステージの画像
  protected PImage[] stageImages = {
    loadImage("images/computer-0.png"),
    loadImage("images/kakomon-0.png"),
    loadImage("images/monster-0.png")
  };

  public Game() {
    this.stage = new Stage(stageNames[stageNum]);
  }

  public void update() {
    stage.update();
    score = prevScore + stage.getScore();

    switch (stage.getStatus()) {
    case Finish:
      // 次のステージへ
      if (stageNum >= stageNames.length - 1) {
        SceneManager.setScene(new Result(score, stageNum + 1, true));
      } else {
        stageNum++;
        this.prevScore = this.score;
        this.stage = new Stage(stageNames[stageNum]);
      }

      break;

    case Reset:
      // ゲームオーバー
      if (life <= 0)
        SceneManager.setScene(new Result(score, stageNum + 1, false));
      life--;

      break;

    default:
      // 1UP
      if (score >= nextOneUpScore) {
        life++;
        nextOneUpScore += ONEUP_SCORE;
        se.oneUp();
      }

      break;
    }
  }

  public void draw() {
    this.stage.draw();

    // スコア表示
    textAlign(RIGHT, BASELINE);

    textFont(font2, 24);
    fill(0, 0, 159);
    text("SCORE", 100, 138);
    text("HIGH SCORE", 465, 138);

    textFont(font2, 24);
    fill(0, 0, 0);
    text(score, 100, 160);
    if (Record.getRanking(1) > score)
      text(Record.getRanking(1), 465, 160);
    else
      text(score, 465, 160);

    // 残基表示
    for (int i = 0; i < life; i++)
      image(lifeImage, i * 32 + 15, 685);

    // ステージ表示
    for (int i = 0; i <= stageNum; i++)
      image(stageImages[i], i * -32 + 433, 685);
  }
}
