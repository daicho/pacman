// パックマンが食べられるアイテム
public class Item extends GameObject {
  protected Animation animation; // アニメーション

  public Item(PVector position, int interval, String itemName) {
    super(position);

    this.animation = new Animation(interval, dataPath("items/" + itemName));
    this.size = animation.getSize();
  }

  // 更新
  public void update() {
    animation.update();
  }

  // 画面描画
  public void draw() {
    PVector minPostision = getMinPosition();
    image(animation.getImage(), minPostision.x, minPostision.y);
  }
}