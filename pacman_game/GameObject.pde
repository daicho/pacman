// ゲーム内オブジェクトの基底クラス
public abstract class GameObject {
  protected PVector position; // 現在位置
  protected PVector size;     // 画像サイズ

  protected GameObject(PVector position) {
    this.position = position;
  }

  public PVector getPosition() {
    return this.position.copy();
  }

  public PVector getSize() {
    return this.size.copy();
  }

  // 左上の座標を取得
  public PVector getMinPosition() {
    return new PVector(position.x - size.x / 2, position.y - size.y / 2);
  }

  // 右下の座標を取得
  public PVector getMaxPosition() {
    return new PVector(position.x + size.x / 2 - 1, position.y + size.y / 2 - 1);
  }

  // 当たり判定
  public boolean isColliding(GameObject object) {
    PVector minPosition = object.getMinPosition();
    PVector maxPosition = object.getMaxPosition();

    // 自分の中心が相手に触れていたら当たり
    return position.x >= minPosition.x &&
      position.x <= maxPosition.x &&
      position.y >= minPosition.y &&
      position.y <= maxPosition.y;
  }

  // 画面描画
  public abstract void draw();
}