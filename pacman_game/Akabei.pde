// アカベエ
public class Akabei extends Monster {
  public Akabei(PVector position, int direction, HashMap<MonsterSpeed, Float> speeds) {
    super(position, direction, speeds, "akabei");
  }

  // 進む方向を決定する
  public void decideDirection(Stage stage) {
    super.decideDirection(stage);
    PVector aimPoint;

    if (status == MonsterStatus.Active) {
      switch (mode) {
      case Rest:
        // 休息中は右上を徘徊
        aimPoint = new PVector(random(stage.map.size.x / 2, stage.map.size.x), random(0, stage.map.size.y / 2));
        direction = getAimDirection(stage.map, aimPoint);
        break;

      case Chase:
        /* ――――――――――――――
         パックマンのいる地点を目指す
         ―――――――――――――― */
        break;

      default:
        break;
      }
    }
  }
}