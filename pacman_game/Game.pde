// ゲーム画面
public class Game implements Scene {
  protected int life;               // 残機の数
  protected int score = 0;          // 現在のスコア
  protected int prevScore = 0;      // 前ステージまでのスコア
  protected int oneUpScore = 10000; // 1UPするスコア

  protected String[] stageNames = {"1", "2", "3"}; // ステージ名
  protected int stageNum = 0; // 現在のステージ番号
  protected Stage stage;      // 現在のステージ
  protected SoundEffect se = new SoundEffect(minim); 

  protected PImage lifeImage = loadImage("images/pacman-3-0.png"); // 残基の画像

  // ステージの画像
  protected PImage[] stageImages = {
    loadImage("images/computer-0.png"), 
    loadImage("images/kakomon-0.png"), 
    loadImage("images/monster-0.png")
  };

  public Game(int life) {
    this.life = life - 1;
    this.stage = new Stage(stageNames[stageNum]);
  }

  public void update() {
    stage.update();
    score = prevScore + stage.getScore();

    switch (stage.getStatus()) {
    case Finish:
      // 次のステージへ
      stageNum++;

      if (stageNum >= stageNames.length) {
        SceneManager.setScene(new Result(score, stageNum + 1, true));
      } else {
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
      if (score >= oneUpScore) {
        life++;
        oneUpScore += 10000;
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
