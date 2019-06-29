// ピンキー
public class Pinky extends Monster {
  public Pinky(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
  }

  // 進む方向を決定する
  public void decideDirection(Map map, Pacman pacman) {
    /* ――――――――――――――――――
       頭脳タイプ、パックマンのいる地点の
       少し前を目指し、先回りするように動く
       ―――――――――――――――――― */
  }
}