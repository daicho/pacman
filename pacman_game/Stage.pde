import java.util.Iterator;

// ステージの状態
public enum StageStatus {
  Start,  // 開始
  Play,   // ゲーム
  Eat,    // 敵を食べたときの硬直
  Clear,  // クリア
  Die,    // 敵に食べられた
  Finish, // 終了
  Reset   // リセット
}

// ステージ
public class Stage implements Scene {
  protected Map map;       // マップ
  protected Pacman pacman; // パックマン
  protected ArrayList<Monster> monsters = new ArrayList<Monster>(); // 敵
  protected ArrayList<Item> foods = new ArrayList<Item>();          // エサ
  protected ArrayList<Item> powerFoods = new ArrayList<Item>();     // パワーエサ
  protected Item specialItem;                        // スペシャルアイテム
  protected int specialItemScore;                    // スペシャルアイテムのスコア
  protected boolean specialItemAppear = false;       // スペシャルアイテムが出現中か
  protected Timer specialItemTimer = new Timer(600); // スペシャルアイテム用タイマー
  protected int foodCount = 0;               // 食べたエサの数
  protected boolean specialItemFlag = false; // 食べたエサが丁度70, 170の時の多数発生回避フラグ
  protected int score = 0; // スコア

  protected StageStatus status = StageStatus.Start; // 状態
  protected Timer dieTimer = new Timer(200);        // 死亡時のタイマー
  protected Timer clearTimer = new Timer(200);       // クリア時のタイマー
  protected Timer eatTimer = new Timer(60);         // 敵を食べたときの硬直タイマー

  protected int frame = 0;           // 経過フレーム
  protected MonsterMode monsterMode; // 敵のモード
  protected HashMap<MonsterMode, Integer> modeTimes =  new HashMap<MonsterMode, Integer>(); // 各モードの時間 [f]
  protected Timer modeTimer;         // モード切り替え用タイマー
  protected int releaseInterval;     // 排出間隔 [f]
  protected int monsterEatCount = 0; // イジケ時に敵を食べた個数

  protected SoundEffect se = new SoundEffect(minim); // 効果音
  protected boolean eatSEFlag = true;                // 普通のエサを食べたときの効果音切り替えフラグ
  protected StartBGM startbgm = new StartBGM(minim); // スタート時のBGM
  protected NomalBGM nomalbgm = new NomalBGM(minim); // 通常時のBGM

  public Stage(String mapName) {
    this.map = new Map(mapName);

    // 設定ファイル読み込み
    HashMap<String, String> setting = new HashMap<String, String>();
    String[] settingLines = loadStrings(dataPath("stages/" + mapName + "-setting.txt"));

    for (String settingLine : settingLines) {
      String[] curSetting = split(settingLine, ',');
      setting.put(curSetting[0], curSetting[1]);
    }

    this.specialItemScore = int(setting.get("special_item_score"));
    this.releaseInterval = int(setting.get("release_interval"));

    this.modeTimes.put(MonsterMode.Rest, int(setting.get("rest_time")));
    this.modeTimes.put(MonsterMode.Chase, int(setting.get("chase_time")));
    this.modeTimes.put(MonsterMode.Ijike, int(setting.get("ijike_time")));

    this.monsterMode = MonsterMode.Rest;
    this.modeTimer = new Timer(modeTimes.get(monsterMode));

    HashMap<MonsterSpeed, Float> monsterSpeeds = new HashMap<MonsterSpeed, Float>();
    monsterSpeeds.put(MonsterSpeed.Wait, float(setting.get("monster_wait_speed")));
    monsterSpeeds.put(MonsterSpeed.Release, float(setting.get("monster_release_speed")));
    monsterSpeeds.put(MonsterSpeed.Return, float(setting.get("monster_return_speed")));
    monsterSpeeds.put(MonsterSpeed.Rest, float(setting.get("monster_rest_speed")));
    monsterSpeeds.put(MonsterSpeed.Chase, float(setting.get("monster_chase_speed")));
    monsterSpeeds.put(MonsterSpeed.Ijike, float(setting.get("monster_ijike_speed")));

    // マップファイル読み込み
    ArrayList<PVector> monsterPositions = new ArrayList<PVector>();
    PImage mapImage = loadImage("stages/" + mapName + "-map.png");
    mapImage.loadPixels();

    for (int y = 0; y < mapImage.height; y++) {
      for (int x = 0; x < mapImage.width; x++) {
        color pixel = mapImage.pixels[y * mapImage.width + x];

        // パックマン
        if (pixel == color(255, 0, 0)) {
          int pacmanDirection = int(setting.get("pacman_direction"));
          float pacmanSpeed = float(setting.get("pacman_speed"));
          this.pacman = new Pacman(new PVector(x, y), pacmanDirection, pacmanSpeed);
        }

        // 敵
        else if (pixel == color(0, 0, 255)) {
          monsterPositions.add(new PVector(x, y));
        }

        // エサ
        else if (pixel == color(255, 255, 0)) {
          foods.add(new Item(new PVector(x, y), "food"));
        }

        // パワーエサ
        else if (pixel == color(0, 255, 255)) {
          powerFoods.add(new Item(new PVector(x, y), "power_food"));
        }

        // スペシャルアイテム
        else if (pixel == color(127, 0, 255)) {
          specialItem = new Item(new PVector(x, y), setting.get("special_item_name"));
        }
      }
    }

    int monsterDirection = int(setting.get("monster_direction"));
    this.monsters.add(new Akabei(monsterPositions.get(0), monsterDirection, monsterSpeeds));
    this.monsters.add(new Aosuke(monsterPositions.get(1), monsterDirection, monsterSpeeds));
    this.monsters.add(new Pinky(monsterPositions.get(2), monsterDirection, monsterSpeeds));
    this.monsters.add(new Guzuta(monsterPositions.get(3), monsterDirection, monsterSpeeds));

    this.draw();
  }

  public int getFrame() {
    return this.frame;
  }

  public int getScore() {
    return this.score;
  }

  public StageStatus getStatus() {
    return this.status;
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

    switch (status) {
    case Start:
      // スタートBGM再生
      if (startbgm.play()) {
        nomalbgm.rewind();  
        status = StageStatus.Play;
      }
      break;

    case Play:
      // モンスター放出
      if (frame < releaseInterval * monsters.size() && frame % releaseInterval == 0)
        this.monsters.get(frame / releaseInterval).setStatus(MonsterStatus.Release);

      // モード切り替え
      if (modeTimer.update()) {
        switch (monsterMode) {
        case Rest:
          monsterMode = MonsterMode.Chase;
          modeTimer.setTime(modeTimes.get(MonsterMode.Chase));
          break;

        case Chase:
        case Ijike:
          monsterMode = MonsterMode.Rest;
          modeTimer.setTime(modeTimes.get(MonsterMode.Rest));
          break;
        }

        for (Monster monster : monsters)
          monster.setMode(monsterMode);
      }

      if (monsterMode == MonsterMode.Ijike && modeTimer.getLeft() == 120) {
        for (Monster monster : monsters)
          monster.setIjikeStatus(1);
      }

      // 敵の向きを決定
      for (Monster monster : monsters)
        monster.decideDirection(this);

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

      if (specialItemAppear == true)
        specialItem.update();

      // 当たり判定
      // ノーマルエサ
      for (Iterator<Item> i = foods.iterator(); i.hasNext(); ) {
        Item food = i.next();

        if (pacman.isColliding(food)) {
          i.remove();

          // 音を鳴らす
          se.eatFood(eatSEFlag);
          eatSEFlag = !eatSEFlag;

          // 食べたエサの数をカウント
          foodCount++;

          // スコア加算
          this.score += 10;
        }
      }

      // パワーエサ
      for (Iterator<Item> i = powerFoods.iterator(); i.hasNext(); ) {
        Item powerFood = i.next();

        if (pacman.isColliding(powerFood)) {
          i.remove();

          // 音を鳴らす
          se.eatPowerFood();

          // イジケモードに
          for (Monster monster : monsters) {
            monster.setMode(MonsterMode.Ijike);
            monsterMode = MonsterMode.Ijike;
            modeTimer.setTime(modeTimes.get(MonsterMode.Ijike));
          }

          this.monsterEatCount = 0;

          // スコア加算
          this.score += 50;
        }
      }

      // スペシャルアイテム
      if (specialItemAppear == true) {
        if (pacman.isColliding(specialItem)) {
          // 音を鳴らす
          se.eatPowerFood();

          // スコア加算
          this.score += specialItemScore;

          // スペシャルアイテムを取得したので終了
          specialItemAppear = false;
        }
      }

      // エサがなくなったらゲームクリア
      if (foods.isEmpty() && powerFoods.isEmpty()) {
        startbgm.rewind();
        status = StageStatus.Clear;
      }

      // 接敵
      for (Iterator<Monster> i = monsters.iterator(); i.hasNext(); ) {
        Monster monster = i.next();

        if (pacman.isColliding(monster)) {
          switch (monster.getStatus()) {
          case Return:
            break;

          case Active:
            if (monster.getMode() == MonsterMode.Ijike) {
              // モンスターを食べた時のスコア
              monsterEatCount++;
              score += pow(2, monsterEatCount) * 100;
              monster.setStatus(MonsterStatus.Return);
              monster.setMode(MonsterMode.Rest);
              se.eatMonster();
              status = StageStatus.Eat;
              break;
            }

          default:
            // 食べられた
            startbgm.rewind();
            se.eaten();
            status = StageStatus.Die;
            return;
          }
        }
      }

      // スペシャルアイテムタイマー
      if (specialItemAppear == true) {
        if (specialItemTimer.update())
          specialItemAppear = false;
      }

      // スペシャルアイテム発生
      if ((foodCount == 70 || foodCount == 170) && specialItemFlag == false) {
        specialItemAppear = true;
        specialItemFlag = true;
      }

      if (foodCount != 70 && foodCount != 170) {
        specialItemFlag = false;
      }

      nomalbgm.play(); // BGMを再生
      frame++;
      break;

    case Eat:
      if (eatTimer.update())
        status = StageStatus.Play;
      break;

    case Clear:
      nomalbgm.pause();
      if (clearTimer.update())
        status = StageStatus.Finish;
      break;

    case Die:
      nomalbgm.pause();
      if (dieTimer.update())
        status = StageStatus.Reset;
      break;

    case Finish:
      break;

    case Reset:
      // リセット
      frame = 0;
      monsterMode = MonsterMode.Rest;
      modeTimer = new Timer(modeTimes.get(monsterMode));

      pacman.reset();
      for (Monster m : monsters)
        m.reset();
      for (Item food : foods)
        food.reset();
      for (Item powerFood : powerFoods)
        powerFood.reset();
      specialItem.reset();

      status = StageStatus.Start;
      break;
    }
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

    if (specialItemAppear == true) {
      specialItem.draw();
    }
  }
}
