// タイトル画面
public class Title implements Scene {
  protected PImage logoImage = loadImage("images/logo.png");
  protected Timer lightTimer1 = new Timer(60); // タイマー
  protected Timer lightTimer2 = new Timer(30); // タイマー
  protected boolean lightAppear = true;
  protected boolean jpEn = false;

  public void update() {
    if (Input.buttonAPress())
      SceneManager.setScene(new Rule());
  }

  public void draw() {
    background(200, 240, 255);
    textAlign(CENTER, CENTER);

    image(logoImage, SCREEN_SIZE.x / 2 - logoImage.width / 2, SCREEN_SIZE.y * 0.08);

    // タイマー
    if (lightAppear == true) {
      fill(0);
      textFont(font2, 32);
      if (jpEn == false) {
        text("ボタンを押してね!", SCREEN_SIZE.x / 2, 260);
      } else {
        text("Press Button 'A'!", SCREEN_SIZE.x / 2, 260);
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
    textFont(font2, 18);
    text("ランキング", SCREEN_SIZE.x * 0.35, 315);
    text("スコア", SCREEN_SIZE.x * 0.65, 315);
    line(SCREEN_SIZE.x * 0.2, 335, SCREEN_SIZE.x * 0.8, 335);
    fill(0);
    textFont(font2, 24);
    for (int i = 0; i < 10; i++) {
      text(i + 1, SCREEN_SIZE.x * 0.35, 350 + i * 30);
      text(Record.getRanking(i + 1), SCREEN_SIZE.x * 0.65, 350 + i * 30);
      line(SCREEN_SIZE.x * 0.2, 365 + i * 30, SCREEN_SIZE.x * 0.8, 365 + i * 30);
    }
    fill(0, 0, 159);
    textFont(font2, 18);
    text("NIT, Nagano College\n © Team Pac-Man 2019", SCREEN_SIZE.x / 2, 700);
  }
}
