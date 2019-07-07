// ピンキー
public class Pinky extends Monster {
  public Pinky(PVector position, int direction, float speed) {
    super(position, direction, speed, "pinky");
  }

  // 進む方向を決定する
  public void decideDirection(Stage stage) {
    super.decideDirection(stage);
    PVector aimPoint;

    if (status == MonsterStatus.Active) {
      switch (mode) {
      case Rest:
        // 休息中は左上を徘徊
        aimPoint = new PVector(random(0, stage.map.size.x / 2), random(0, stage.map.size.y / 2));
        direction = getAimDirection(stage.map, aimPoint);
        break;

      case Chase:
        /* ―――――――――――――――――――
         パックマンのいる地点の3マス先を目指す
         ――――――――――――――――――― */
        break;

      default:
        break;
      }
    }
  }
}
