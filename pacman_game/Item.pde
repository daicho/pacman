// パックマンが食べられるアイテム
public class Item extends GameObject {
  protected PImage[] images;  // 画像
  protected int curAnimetion; // 現在のアニメーション番号
  protected int animetionNum; // アニメーションの数
  protected int interval;     // アニメーションの間隔 [f]
  protected int intervalLeft; // あと何fで次のアニメーションにいくか

  public Item(PVector position, String itemName, int interval) {
    super(position);

    this.curAnimetion = 0;
    this.interval = interval;
    this.intervalLeft = interval;

    // 画像ファイルの存在確認
    this.animetionNum = 0;
    while (true) {
      File imageFile = new File(dataPath("items/" + itemName + "-" + animetionNum + ".png"));
      if (!imageFile.exists())
        break;

      this.animetionNum++;
    }

    // 画像ファイル読み込み
    this.images = new PImage[animetionNum];

    for (int i = 0; i < animetionNum; i++) {
      this.images[i] = loadImage(dataPath("items/" + itemName + "-" + i + ".png"));
    }

    this.size = new PVector(images[0].width, images[0].height);
  }

  // 画面描画
  public void draw() {
    if (exist) {
      PVector minPostision = getMinPosition();
      image(images[curAnimetion], minPostision.x, minPostision.y);
    }

    // アニメーションを更新
    if (interval > 0) {
      this.intervalLeft--;
      if (intervalLeft < 0) {
        intervalLeft = interval;
        curAnimetion = (curAnimetion + 1) % animetionNum;
      }
    }
  }
}