public class Animation {
  protected PImage[] images;  // アニメーション画像
  protected int cur;          // 現在のアニメーション番号
  protected int number;       // アニメーションの数
  protected int interval;     // アニメーションの間隔 [f]
  protected int intervalLeft; // あと何fで次のアニメーションにいくか
  
  public Animation(int interval, String filePath) {
    this.cur = 0;
    this.interval = interval;
    this.intervalLeft = interval;
    
    // 画像ファイルの存在確認
    this.number = 0;
    while (true) {
      File imageFile = new File(filePath + "-" + number + ".png");
      if (!imageFile.exists())
        break;

      this.number++;
    }

    // 画像ファイル読み込み
    this.images = new PImage[number];
    for (int i = 0; i < number; i++)
        this.images[i] = loadImage(filePath + "-" + i +  ".png");
  }
  
  // アニメーションを更新
  public void update() {
    if (interval > 0) {
      intervalLeft--;
      if (intervalLeft < 0) {
        intervalLeft = interval;
        cur = (cur + 1) % number;
      }
    }
  }
  
  // 画像を取得
  public PImage getImage() {
    return images[cur];
  }

  // 画像サイズを取得
  public PVector getSize() {
    return new PVector(images[0].width, images[0].height);
  }
}