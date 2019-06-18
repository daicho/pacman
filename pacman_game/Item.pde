// パックマンが食べられるアイテム
public class Item {
  private PVector position;  // 位置
  private boolean exist;     // 存在するか
  private PImage image;      // 画像
  private String imageName; // 画像ファイル名

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