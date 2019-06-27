// パックマンが食べられるアイテム
public class Item extends GameObject {
  protected String imageName; // 画像ファイル名
  protected PImage image;     // 画像

  public Item(PVector position, String imageName) {
    super(position);
    this.imageName = imageName;

    // 画像ファイル読み込み
    image = loadImage(dataPath("items/" + imageName + ".png"));
    this.size = new PVector(image.width, image.height);
  }

  // 画面描画
  public void draw() {
    if (exist) {
      PVector minPostision = getMinPosition();
      image(image, minPostision.x, minPostision.y);
    }
  }
}