// タイトル画面
public class Title implements Scene {
  protected PImage logoImage = loadImage("images/logo.png");
  protected PImage pressButonImage = loadImage("images/pressbutton.png");
  protected PImage copyrightImage = loadImage("images/copyright.png");
  protected Timer lightTimer1 = new Timer(30); // タイマー
  protected Timer lightTimer2 = new Timer(15); // タイマー
  protected boolean lightAppear = true;
  protected boolean jpEn = false;

  protected Timer startTimer = new Timer(10); // タイマー
  protected boolean startAppear = true;
  protected int startCount = 0;

  private final FreeCharacter[] freeCharacters = {
    new FreeCharacter(new PVector(0, SCREEN_SIZE.y * 0.08 - 15), 0, 2.3, "pacman"), 
    new FreeCharacter(new PVector(0, SCREEN_SIZE.y * 0.08 - 15), 0, 2.3, "akabei"), 
    new FreeCharacter(new PVector(0, SCREEN_SIZE.y * 0.08 - 15), 0, 2.3, "aosuke"), 
    new FreeCharacter(new PVector(0, SCREEN_SIZE.y * 0.08 - 15), 0, 2.3, "pinky"), 
    new FreeCharacter(new PVector(0, SCREEN_SIZE.y * 0.08 - 15), 0, 2.3, "guzuta")
  };

  public void update() {
    if (Input.buttonAPress())
      SceneManager.setScene(new Rule());
  }

  public void draw() {
    background(200, 240, 255);
    noStroke();
    textAlign(CENTER, CENTER);

    image(logoImage, SCREEN_SIZE.x / 2 - logoImage.width / 2, SCREEN_SIZE.y * 0.08);

    // タイマー
    if (lightAppear == true) {
      fill(0);
      textFont(font2, 40);
      if (jpEn == false) {
        text("ボタンをおしてね!", SCREEN_SIZE.x / 2, 260);
      } else {
        image(pressButonImage, SCREEN_SIZE.x / 2 - pressButonImage.width / 2, 250);
      }
      if (lightTimer1.update()) {
        lightAppear = false;
        jpEn = !jpEn;
      }
    }

    if (lightAppear == false) {
      if (lightTimer2.update())
        lightAppear = true;
    }

    fill(0, 0, 159);
    textFont(font2, 22.5);
    text("ランキング", SCREEN_SIZE.x * 0.35, 315);
    text("スコア", SCREEN_SIZE.x * 0.65, 315);
    fill(0);
    rect(SCREEN_SIZE.x * 0.2, 336, SCREEN_SIZE.x * 0.6, 1);
    textFont(font2, 30);
    for (int i = 0; i < 10; i++) {
      text(i + 1, SCREEN_SIZE.x * 0.35, 350 + i * 30);
      text(Record.getRanking(i + 1), SCREEN_SIZE.x * 0.65, 350 + i * 30);
      line(SCREEN_SIZE.x * 0.2, 365 + i * 30, SCREEN_SIZE.x * 0.8, 365 + i * 30);
      rect(SCREEN_SIZE.x * 0.2, 366 + i * 30, SCREEN_SIZE.x * 0.6, 1);
    }
    image(copyrightImage, SCREEN_SIZE.x / 2 - copyrightImage.width / 2, 700);

    for (int i = 0; i < 5; i++) {
      if (startCount > i) {
        freeCharacters[i].move();
        freeCharacters[i].update();
        freeCharacters[i].draw();
        if (freeCharacters[i].getDirection() == 0 && freeCharacters[i].position.x >= SCREEN_SIZE.x / 2 + logoImage.width / 2 + 15) {
          freeCharacters[i].setDirection(3);
        } else if (freeCharacters[i].getDirection() == 3 && freeCharacters[i].position.y >= SCREEN_SIZE.y * 0.08 + logoImage.height + 15) {
          freeCharacters[i].setDirection(2);
        } else if (freeCharacters[i].getDirection() == 2 && freeCharacters[i].position.x <= SCREEN_SIZE.x / 2 - logoImage.width / 2 - 15) {
          freeCharacters[i].setDirection(1);
        } else if (freeCharacters[i].getDirection() == 1 && freeCharacters[i].position.y <= SCREEN_SIZE.y * 0.08 - 15) {
          freeCharacters[i].setDirection(0);
        }
      }
    }


    // タイマー
    if (startAppear == true) {
      if (startTimer.update()) {
        startAppear = false;
        startCount ++;
      }
    }

    if (startAppear == false) {
      if (startTimer.update())
        startAppear = true;
    }
  }
}