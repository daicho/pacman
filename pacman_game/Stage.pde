// ステージ
public class Stage {
  protected Pacman pacman;        // パックマン
  protected ArrayList<Monster> monsters;   // 敵
  protected Map map;              // マップ
  protected InputInterface input; // 入力インターフェース
  protected String stageName;     // ファイル読み込みに用いるステージ名

  Stage(String stageName, InputInterface input) {
    this.stageName = stageName;
    this.map = new Map(stageName);
    this.input = input;

    this.pacman = new Pacman(map.pacmanPosition, 0, 0.8, "pacman", 5);
    this.monsters = new ArrayList<Monster>();
    this.monsters.add(new Akabei(map.enemyPositions.get(0), 0, 0.8, "akabei", 5));
    this.monsters.add(new Aosuke(map.enemyPositions.get(1), 0, 0.8, "aosuke", 5));
    this.monsters.add(new Pinky (map.enemyPositions.get(2), 0, 0.8, "pinky" , 5));
    this.monsters.add(new Guzuta(map.enemyPositions.get(3), 0, 0.8, "guzuta", 5));
  }

  // ステージ内の状態を更新
  public void update() {
    // ボタン入力
    if (input.right())
      pacman.setNextDirection(0); // →
    else if (input.up())
      pacman.setNextDirection(1); // ↑
    else if (input.left())
      pacman.setNextDirection(2); // ←
    else if (input.down())
      pacman.setNextDirection(3); // ↓

    // パックマンと敵の向きを決定
    for (Monster monster : monsters)
      monster.decideDirection(map, pacman);
    pacman.decideDirection(map);

    // 移動
    for (Monster monster : monsters)
      monster.move(map);
    pacman.move(map);
  }

  // 画面描画
  public void draw() {
    background(0);
    map.draw();
    for (Monster monster : monsters)
      monster.draw();
    pacman.draw();
  }
}