// グズタ
public class Guzuta extends Monster {
  public Guzuta(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
  }

  // 進む方向を決定する
  public void decideDirection(Map map, Pacman pacman) {
    /* ――――――――――――――――――――
       好き勝手タイプ、何も考えず自由に行動する
       ―――――――――――――――――――― */
  }
}