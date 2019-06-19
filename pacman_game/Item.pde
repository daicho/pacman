// パックマンが食べられるアイテム
public class Item {
  protected PVector position;  // 位置
  protected boolean exist;     // 存在するか
  protected PImage image;      // 画像
  protected String imageName; // 画像ファイル名

  public Item(PVector position, String imageName) {
    this.position = position;
    this.imageName = imageName;

    // 画像ファイル読み込み
  }

  public PVector getPosition() {
      return this.position;
  }

  public boolean getExist() {
      return this.exist;
  }

  // 消失させる
  public void disappear() {
      this.exist = false;
  }

  // 画面描画
  public void draw() {

  }
}