// ピンキー
public class Pinky extends Monster {
  public Pinky(PVector position, int direction, HashMap<MonsterSpeed, Float> speeds) {
    super(position, direction, speeds, "pinky");
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
        nextDirection = getAimDirection(stage.map, aimPoint);
        break;

      case Chase:
        // パックマンのいる地点の3マス先を目指す
        PVector directionVector = getDirectionVector(stage.pacman.direction).mult(3);
        aimPoint = stage.pacman.getPosition();
        aimPoint.add(directionVector.x * stage.pacman.size.x, directionVector.y * stage.pacman.size.y);
        nextDirection = getAimDirection(stage.map, aimPoint);
        break;

      default:
        break;
      }
    }
  }
}
