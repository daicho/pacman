// ステージ
public class Stage {
  protected Pacman pacman;               // パックマン
  protected ArrayList<Monster> monsters; // 敵
  protected Map map;                     // マップ
  protected InputInterface input;        // 入力インターフェース
  protected int score;                   // スコア

  public Stage(String mapName, InputInterface input) {
    this.map = new Map(mapName);
    this.input = input;

    this.pacman = new Pacman(map.pacmanPosition, 0, 1.6, "pacman", 5);
    this.monsters = new ArrayList<Monster>();
    this.monsters.add(new Akabei(map.enemyPositions.get(0), 0, 1.6, "akabei", 5));
    this.monsters.add(new Aosuke(map.enemyPositions.get(1), 0, 1.6, "aosuke", 5));
    this.monsters.add(new Pinky (map.enemyPositions.get(2), 0, 1.6, "pinky" , 5));
    this.monsters.add(new Guzuta(map.enemyPositions.get(3), 0, 1.6, "guzuta", 5));
  }

  public int getScore() {
    return this.score;
  }

  public void setScore(int score) {
    this.score = score;
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
    
    // 当たり判定
    for (Item food : map.foods)
      if (food.getExist() && pacman.isColliding(food)) {
        /* ―――――
           音を鳴らす
           ――――― */

        food.disappear();
      }

    for (Item powerFood : map.powerFoods)
      if (powerFood.getExist() && pacman.isColliding(powerFood)) {
        /* ―――――
           音を鳴らす
           ――――― */

        /* ―――――――――――――――
           パックマンを無敵モードにし、
           モンスターをイジケモードにする
           何秒か経ったら通常モードに戻す
           (本家は8秒)
           ――――――――――――――― */

        powerFood.disappear();
      }

    for (Monster monster : monsters)
      if (pacman.isColliding(monster)) {
        if (monster.ijike) {
          monster.disappear(); // とりあえずモンスター消しとく
        } else {
          ; /* ゲームオーバー */
        }
      }
  }

  // 画面描画
  public void draw() {
    background(0);
    map.draw();
    pacman.draw();

    for (Monster monster : monsters)
      monster.draw();
  }
}