// ルール説明画面
public class Rule implements Scene {
  private final FreeCharacter FreePacman = new FreeCharacter(new PVector(214, 247), 0, 1.6, "pacman");
  private final FreeCharacter[] FreeMonsters = {
    new FreeCharacter(new PVector(179, 370), 3, 1.6, "akabei"), 
    new FreeCharacter(new PVector(220, 370), 3, 1.6, "aosuke"), 
    new FreeCharacter(new PVector(260, 370), 3, 1.6, "pinky"), 
    new FreeCharacter(new PVector(301, 370), 3, 1.6, "ohya")
  };
  protected Timer lightTimer1 = new Timer(30); // 1秒タイマー
  protected Timer lightTimer2 = new Timer(15); // 0.5秒タイマー
  protected boolean lightAppear = true;

  protected Item bigPowerFood = new Item(new PVector(86, 547), "big_power_food");

  public void update() {
    if (Input.anyButtonPress())
      SceneManager.setScene(new Game(3));
  }

  public void draw() {
    boolean imageLoadFlag = false;
    if (imageLoadFlag == false) {
      PImage ruleImage = loadImage("images/rule.png");
      image(ruleImage, 0, 0);
      imageLoadFlag = true;
    }
    FreePacman.draw();
    FreePacman.update();
    for (int i = 0; i < 4; i++) {
      FreeMonsters[i].draw();
      FreeMonsters[i].update();
      FreeMonsters[i].move();
      if (FreeMonsters[i].getDirection() == 3 && FreeMonsters[i].position.y >= 400)
        FreeMonsters[i].setDirection(1);
      else if (FreeMonsters[i].getDirection() == 1 && FreeMonsters[i].position.y <= 345)
        FreeMonsters[i].setDirection(3);
    }

    // タイマー
    if (lightAppear == true) {
      fill(0, 0, 159);
      textFont(font2, 40);
      text("ボタンをおして", SCREEN_SIZE.x / 2 + 6, 706);
      text("ゲームスタート！", SCREEN_SIZE.x / 2 + 6, 754);
    }
    if (lightTimer1.update())
      lightAppear = false;
    if (lightAppear == false) {
      if (lightTimer2.update())
        lightAppear = true;
    }
    bigPowerFood.draw();
    bigPowerFood.update();
  }
}
