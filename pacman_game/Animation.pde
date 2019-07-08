// アニメーション
public class Animation {
  protected PImage[] images;     // アニメーション画像
  protected int cur = 0;         // 現在のアニメーション番号
  protected int number;          // アニメーションの数
  protected Timer intervalTimer; // インターバルタイマー

  public Animation(String imageName) {
    // 画像ファイルの存在確認
    this.number = 0;
    while (true) {
      File imageFile = new File(dataPath("images/" + imageName + "-" + number + ".png"));
      if (!imageFile.exists())
        break;

      this.number++;
    }

    // 画像ファイル読み込み
    this.images = new PImage[number];
    for (int i = 0; i < number; i++)
      this.images[i] = loadImage(dataPath("images/" + imageName + "-" + i + ".png"));

    // インターバル読み込み
    String[] intervalText = loadStrings(dataPath("images/" + imageName + "-interval.txt"));
    this.intervalTimer = new Timer(int(intervalText[0]));
  }

  // アニメーションを更新しアニメーションの終端ならばtrueを返す
  public boolean update() {
    if (intervalTimer.update()) {
      cur++;
      if (cur >= number) {
        cur = 0;
        return true;
      }
    }

    return false;
  }

  // 初期状態にリセット
  public void reset() {
    cur = 0;
    intervalTimer.reset();
  }

  // 画像を取得
  public PImage getImage() {
    return images[cur].copy();
  }

  // 画像サイズを取得
  public PVector getSize() {
    return new PVector(images[0].width, images[0].height);
  }
}
