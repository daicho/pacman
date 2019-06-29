// アカベエ
public class Akabei extends Monster {
  public Akabei(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
  }

  // 進む方向を決定する
  public void decideDirection(Map map, Pacman pacman) {
    /* ―――――――――――――――――――
       粘着タイプ、パックマンの後を追いかける
       ――――――――――――――――――― */
  }
}