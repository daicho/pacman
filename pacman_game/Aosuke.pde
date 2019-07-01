// アオスケ
public class Aosuke extends Monster {
  public Aosuke(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
  }

  // 進む方向を決定する
  public void decideDirection(Stage stage) {
    // パックマンを中心にしてアカベイの点対象の地点を目指す
    PVector aimPoint = stage.pacman.position.copy();
    aimPoint.mult(2);
    aimPoint.sub(stage.monsters.get(1).position);

    direction = getAimDirection(stage.map, aimPoint);
  }
}