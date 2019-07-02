// アオスケ
public class Aosuke extends Monster {
  public Aosuke(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
  }

  // 進む方向を決定する
  public void decideDirection(Stage stage) {
    super.decideDirection(stage);
    PVector aimPoint;

    switch (status) {
    case Rest:
      // 休息中は右下を徘徊
      aimPoint = new PVector(random(stage.map.size.x / 2, stage.map.size.x), random(stage.map.size.y / 2, stage.map.size.y));
      direction = getAimDirection(stage.map, aimPoint);
      break;

    case Chase:
      // パックマンを中心にしてアカベイの点対象の地点を目指す
      aimPoint = stage.pacman.position.copy();
      aimPoint.mult(2);
      aimPoint.sub(stage.monsters.get(0).position);
      direction = getAimDirection(stage.map, aimPoint);
      break;

    default:
      break;
    }
  }
}
