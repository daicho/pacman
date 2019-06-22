// パックマンが食べられるアイテム
public class Item {
  protected PVector position; // 位置
  protected boolean exist;    // 存在するか
  protected String imageName; // 画像ファイル名
  protected PImage image;     // 画像
  protected PVector size;     // 画像サイズ

  public Item(PVector position, String imageName) {
    this.position = position;
    this.exist = true;
    this.imageName = imageName;

    // 画像ファイル読み込み
    image = loadImage(dataPath("items/" + imageName + ".png"));
    this.size = new PVector(image.width, image.height);
    
  }

  // 左上の座標を取得
  public PVector getMinPosition() {
    return new PVector(position.x - size.x / 2, position.y - size.y / 2);
  }

  // 右下の座標を取得
  public PVector getManPosition() {
    return new PVector(position.x + size.x / 2, position.y + size.y / 2);
  }

  public PVector getPosition() {
    return this.position;
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
    PVector minPostision = getMinPosition();
    image(image, minPostision.x, minPostision.y);
  }
}