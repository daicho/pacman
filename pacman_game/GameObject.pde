// ゲーム内オブジェクトの基底クラス
public abstract class GameObject {
  protected PVector position; // 現在位置
  protected PVector size;     // 画像サイズ
  protected boolean exist;    // 存在するか

  protected GameObject(PVector position) {
    this.position = position;
    this.exist = true;
  }

  // 特定の方向の単位ベクトル
  protected PVector getDirectionVector(int direction) {
    switch (direction) {
    case 0: // 右
      return new PVector(1, 0);

    case 1: // 上
      return new PVector(0, -1);

    case 2: // 左
      return new PVector(-1, 0);

    case 3: // 下
      return new PVector(0, 1);

    default:
      return new PVector(0, 0);
    }
  }

  public PVector getPosition() {
    return this.position;
  }

  public PVector getSize() {
    return this.size;
  }

  public boolean getExist() {
    return this.exist;
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

  // 消失させる
  public void disappear() {
    exist = false;
  }

  // 画面描画
  public abstract void draw();
}