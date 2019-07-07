// グズタ
public class Guzuta extends Monster {
  public Guzuta(PVector position, int direction, float speed) {
    super(position, direction, speed, "guzuta");
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
        direction = getAimDirection(stage.map, aimPoint);
        break;

      case Chase:
        /* ――――――――――――――――――――――――――
         パックマンから半径260px外ではアカベイと同じ追跡方法、
         半径260px内ではランダムに動く
         ―――――――――――――――――――――――――― */
        break;

      default:
        break;
      }
    }
  }
}
