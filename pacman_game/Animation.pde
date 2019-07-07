// アニメーション
public class Animation {
  protected PImage[] images;  // アニメーション画像
  protected int cur = 0;      // 現在のアニメーション番号
  protected int number;       // アニメーションの数
  protected int interval;     // アニメーションの間隔 [f]
  protected int intervalLeft; // あと何fで次のアニメーションにいくか

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
    interval = int(intervalText[0]);
    intervalLeft = interval;
  }

  // アニメーションを更新しアニメーションの終端ならばtrueを返す
  public boolean update() {
    if (interval > 0) {
      intervalLeft--;
      if (intervalLeft < 0) {
        intervalLeft = interval;

        cur++;
        if (cur >= number) {
          cur = 0;
          return true;
        }
      }
    }

    return false;
  }

  // 初期状態にリセット
  public void reset() {
    cur = 0;
    intervalLeft = interval;
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