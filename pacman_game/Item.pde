// パックマンが食べられるアイテム
public class Item extends GameObject {
  protected boolean exist;    // 存在するか
  protected String imageName; // 画像ファイル名
  protected PImage image;     // 画像

  public Item(PVector position, String imageName) {
    super(position);

    this.exist = true;
    this.imageName = imageName;

    // 画像ファイル読み込み
    image = loadImage(dataPath("items/" + imageName + ".png"));
    this.size = new PVector(image.width, image.height);
  }

  public boolean getExist() {
    return this.exist;
  }

  // 消失させる
  public void disappear() {
    exist = false;
  }

  // 画面描画
  public void draw() {
    if (exist) {
      PVector minPostision = getMinPosition();
      image(image, minPostision.x, minPostision.y);
    }
  }
}