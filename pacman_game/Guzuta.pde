// グズタ
public class Guzuta extends Monster {
  public Guzuta(PVector position, int direction, HashMap<MonsterSpeed, Float> speeds) {
    super(position, direction, speeds, "guzuta");
  }

  // 進む方向を決定する
  public void decideDirection(Stage stage) {
    super.decideDirection(stage);
    PVector aimPoint;

    if (status == MonsterStatus.Active) {
      switch (mode) {
      case Rest:
        // 休息中は左下を徘徊
        aimPoint = new PVector(random(0, stage.map.size.x / 2), random(stage.map.size.y / 2, stage.map.size.y));
        nextDirection = getAimDirection(stage.map, aimPoint);
        break;

      case Chase:
        // パックマンから半径260px外ではアカベイと同じ追跡方法
        if (position.dist(stage.pacman.position) > 260) {
          nextDirection = getAimDirection(stage.map, stage.pacman.getPosition());
        }

        // 半径260px内ではランダムに動く
        else {
          aimPoint = new PVector(position.x + random(-1, 1), position.y + random(-1, 1));
          nextDirection = getAimDirection(stage.map, aimPoint);
        }
        break;

      default:
        break;
      }
    }
  }
}
