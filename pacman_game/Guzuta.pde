// グズタ
public class Guzuta extends Monster {
  public Guzuta(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
  }

  // 進む方向を決定する
  public void decideDirection(Stage stage) {
    /* ――――――――――――――――――――――――――
       パックマンから半径260px外ではアカベイと同じ追跡方法、
       半径260px内ではランダムに動く
       ―――――――――――――――――――――――――― */
  }
}