import java.util.Iterator;

// ステージ
public class Stage implements Scene {
  protected Pacman pacman; // パックマン
  protected ArrayList<Monster> monsters = new ArrayList<Monster>(); // 敵
  protected ArrayList<Item> foods = new ArrayList<Item>();          // エサ
  protected ArrayList<Item> powerFoods = new ArrayList<Item>();     // パワーエサ
  protected Map map;       // マップ
  protected int frame = 0; // 経過フレーム
  protected int score = 0; // スコア
  protected int monsterEatCount = 4; // イジケ時に敵を食べた個数
  protected int life = 3;  // 残機の数

  public Stage(String mapName) {
    this.map = new Map(mapName);
    this.pacman = new Pacman(map.getPacmanStartPosition(), 2, 1.6, 3, "pacman");
    this.monsters.add(new Akabei(map.getMonsterStartPosition(0), 1, 1.6, 5, "akabei"));
    this.monsters.add(new Pinky (map.getMonsterStartPosition(2), 1, 1.6, 5, "pinky" ));
    this.monsters.add(new Aosuke(map.getMonsterStartPosition(1), 1, 1.6, 5, "aosuke"));
    this.monsters.add(new Guzuta(map.getMonsterStartPosition(3), 1, 1.6, 5, "guzuta"));
    
    // マップファイル読み込み
    PImage mapImage = loadImage("maps/" + mapName + "-map.png");
    mapImage.loadPixels();

    for (int y = 0; y < mapImage.height; y++) {
      for (int x = 0; x < mapImage.width; x++) {
        color pixel = mapImage.pixels[y * mapImage.width + x];

        // エサ
        if (pixel == color(255, 255, 0)) {
          foods.add(new Item(new PVector(x, y), 0, "food"));
        }

        // パワーエサ
        else if (pixel == color(0, 255, 255)) {
          powerFoods.add(new Item(new PVector(x, y), 10, "power_food"));
        }
      }
    }

    this.draw();
  }

  public int getScore() {
    return this.score;
  }

  // ステージ内の状態を更新
  public void update() {
    // ボタン入力
    if (Input.right())
      pacman.setNextDirection(0); // →
    else if (Input.up())
      pacman.setNextDirection(1); // ↑
    else if (Input.left())
      pacman.setNextDirection(2); // ←
    else if (Input.down())
      pacman.setNextDirection(3); // ↓

    // モンスター放出
    switch (frame) {
    case 0:
      this.monsters.get(0).setStatus(MonsterStatus.Release);
      break;

    case 300:
      this.monsters.get(1).setStatus(MonsterStatus.Release);
      break;

    case 600:
      this.monsters.get(2).setStatus(MonsterStatus.Release);
      break;

    case 900:
      this.monsters.get(3).setStatus(MonsterStatus.Release);
      break;
    }

    // パックマンと敵の向きを決定
    for (Monster monster : monsters)
      monster.decideDirection(this);
    pacman.decideDirection(this);

    // 移動
    for (Monster monster : monsters)
      monster.move(map);
    pacman.move(map);

    // 更新
    pacman.update(map);

    for (Monster monster : monsters)
      monster.update(map);

    for (Item food : foods)
      food.update();

    for (Item powerFood : powerFoods)
      powerFood.update();

    // 当たり判定
    for (Iterator<Item> i = foods.iterator(); i.hasNext(); ) {
      Item food = i.next();

      if (pacman.isColliding(food)) {
        /* ―――――
         音を鳴らす
         ――――― */
        this.score += 10;
        i.remove();
      }
    }

    for (Iterator<Item> i = powerFoods.iterator(); i.hasNext(); ) {
      Item powerFood = i.next();

      if (pacman.isColliding(powerFood)) {
        /* ―――――
         音を鳴らす
         ――――― */

        for (Monster monster : monsters) {
          if (monster.status != MonsterStatus.Return) {
            monster.setMode(MonsterMode.Ijike);
            monster.setIjikeTime(480);
          }
        }

        this.monsterEatCount = 0;
        this.score += 50;
        i.remove();
      }
    }

    if (foods.isEmpty() && powerFoods.isEmpty()) {
      SceneManager.setScene(new Stage("original"));
    }

    for (Iterator<Monster> i = monsters.iterator(); i.hasNext(); ) {
      Monster monster = i.next();

      if (pacman.isColliding(monster)) {
        switch (monster.getStatus()) {
        case Return:
          break;

        case Active:
          if (monster.getMode() == MonsterMode.Ijike) {
            // モンスターを食べた時のスコア
            this.monsterEatCount++;

            switch (this.monsterEatCount) {
            case 1:
              this.score += 200;
              break;

            case 2:
              this.score += 400;
              break;

            case 3:
              this.score += 800;
              break;

            case 4:
              this.score += 1600;
              break;
            }
            monster.setStatus(MonsterStatus.Return);
            break;
          }

        default:
          if (life <= 0) {
            // ゲームオーバー
            SceneManager.setScene(new Result(score));
          } else {
            // 残機を1つ減らしゲーム続行
            life--;
            println(life);

            // パックマン
            pacman.setPosition(map.getPacmanStartPosition());
            pacman.setDirection(2);

            // 敵
            monsters.get(0).setPosition(map.getMonsterStartPosition(0)); // アカベエ
            monsters.get(1).setPosition(map.getMonsterStartPosition(2)); // ピンキー
            monsters.get(2).setPosition(map.getMonsterStartPosition(1)); // アオスケ
            monsters.get(3).setPosition(map.getMonsterStartPosition(3)); // グズタ

            for (int m = 0; m < monsters.size(); m++) {
              monsters.get(m).setStatus(MonsterStatus.Wait);
              monsters.get(m).setMode(MonsterMode.Rest);
              monsters.get(m).setDirection(1);
            }

            frame = 0;
            update();
          }
          break;
        }
      }
    }

    frame++;
  }

  // 画面描画
  public void draw() {
    background(0);
    map.draw();

    for (Item food : foods)
      food.draw();

    for (Item powerFood : powerFoods)
      powerFood.draw();

    pacman.draw();

    for (Monster monster : monsters)
      monster.draw();

    // スコア表示
    fill(255);
    textAlign(RIGHT, BASELINE);
    textFont(font, 20);
    text("SCORE", 75, 180);
    text(score, 75, 200);
  }
}