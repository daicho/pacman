// ゲーム内オブジェクトの基底クラス
public abstract class GameObject {
  protected PVector position; // 現在位置
  protected PVector size;     // 画像サイズ

  protected GameObject(PVector position) {
    this.position = position;
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

  // 左上の座標を取得
  public PVector getMinPosition() {
    return new PVector(position.x - size.x / 2, position.y - size.y / 2);
  }

  // 右下の座標を取得
  public PVector getManPosition() {
    return new PVector(position.x + size.x / 2, position.y + size.y / 2);
  }

  // 当たり判定
  public boolean isColliding(GameObject object) {
    /* ―――――――――――――――――――――
       当たり判定は、中心付近にのみ発生する
       (PVector型の要素はfloat型なので扱いに注意)
       ――――――――――――――――――――― */
    return false;
  }

  // 画面描画
  public abstract void draw();
}