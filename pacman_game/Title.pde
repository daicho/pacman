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
  //protected boolean startAppear = true;
  //protected int startCount = 0;

  protected FreeCharacter pacman =
    new FreeCharacter(new PVector(210, SCREEN_SIZE.y * 0.08 - 15), 0, 2.3, "pacman");
  protected FreeCharacter akabei =
    new FreeCharacter(new PVector(150, SCREEN_SIZE.y * 0.08 - 15), 0, 2.3, "akabei");
  protected FreeCharacter aosuke =
    new FreeCharacter(new PVector(100, SCREEN_SIZE.y * 0.08 - 15), 0, 2.3, "aosuke");
  protected FreeCharacter pinky =
    new FreeCharacter(new PVector(50, SCREEN_SIZE.y * 0.08 - 15), 0, 2.3, "pinky");
  protected FreeCharacter guzuta =
    new FreeCharacter(new PVector(0, SCREEN_SIZE.y * 0.08 - 15), 0, 2.3, "guzuta");


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
    rect(SCREEN_SIZE.x * 0.2, 335, SCREEN_SIZE.x * 0.6, 2);
    textFont(font2, 30);
    for (int i = 0; i < 10; i++) {
      text(i + 1, SCREEN_SIZE.x * 0.35, 350 + i * 30);
      text(Record.getRanking(i + 1), SCREEN_SIZE.x * 0.65, 350 + i * 30);
      line(SCREEN_SIZE.x * 0.2, 365 + i * 30, SCREEN_SIZE.x * 0.8, 365 + i * 30);
      rect(SCREEN_SIZE.x * 0.2, 365 + i * 30, SCREEN_SIZE.x * 0.6, 2);
    }
    image(copyrightImage, SCREEN_SIZE.x / 2 - copyrightImage.width / 2, 700);

    pacman.move();
    pacman.update();
    pacman.draw();
    if (pacman.getDirection() == 0 && pacman.position.x >= SCREEN_SIZE.x / 2 + logoImage.width / 2 + 15) {
      pacman.setDirection(3);
    } else if (pacman.getDirection() == 3 && pacman.position.y >= SCREEN_SIZE.y * 0.08 + logoImage.height + 15) {
      pacman.setDirection(2);
    } else if (pacman.getDirection() == 2 && pacman.position.x <= SCREEN_SIZE.x / 2 - logoImage.width / 2 - 15) {
      pacman.setDirection(1);
    } else if (pacman.getDirection() == 1 && pacman.position.y <= SCREEN_SIZE.y * 0.08 - 15) {
      pacman.setDirection(0);
    }
    akabei.move();
    akabei.update();
    akabei.draw();
    if (akabei.getDirection() == 0 && akabei.position.x >= SCREEN_SIZE.x / 2 + logoImage.width / 2 + 15) {
      akabei.setDirection(3);
    } else if (akabei.getDirection() == 3 && akabei.position.y >= SCREEN_SIZE.y * 0.08 + logoImage.height + 15) {
      akabei.setDirection(2);
    } else if (akabei.getDirection() == 2 && akabei.position.x <= SCREEN_SIZE.x / 2 - logoImage.width / 2 - 15) {
      akabei.setDirection(1);
    } else if (akabei.getDirection() == 1 && akabei.position.y <= SCREEN_SIZE.y * 0.08 - 15) {
      akabei.setDirection(0);
    }
    aosuke.move();
    aosuke.update();
    aosuke.draw();
    if (aosuke.getDirection() == 0 && aosuke.position.x >= SCREEN_SIZE.x / 2 + logoImage.width / 2 + 15) {
      aosuke.setDirection(3);
    } else if (aosuke.getDirection() == 3 && aosuke.position.y >= SCREEN_SIZE.y * 0.08 + logoImage.height + 15) {
      aosuke.setDirection(2);
    } else if (aosuke.getDirection() == 2 && aosuke.position.x <= SCREEN_SIZE.x / 2 - logoImage.width / 2 - 15) {
      aosuke.setDirection(1);
    } else if (aosuke.getDirection() == 1 && aosuke.position.y <= SCREEN_SIZE.y * 0.08 - 15) {
      aosuke.setDirection(0);
    }
    pinky.move();
    pinky.update();
    pinky.draw();
    if (pinky.getDirection() == 0 && pinky.position.x >= SCREEN_SIZE.x / 2 + logoImage.width / 2 + 15) {
      pinky.setDirection(3);
    } else if (pinky.getDirection() == 3 && pinky.position.y >= SCREEN_SIZE.y * 0.08 + logoImage.height + 15) {
      pinky.setDirection(2);
    } else if (pinky.getDirection() == 2 && pinky.position.x <= SCREEN_SIZE.x / 2 - logoImage.width / 2 - 15) {
      pinky.setDirection(1);
    } else if (pinky.getDirection() == 1 && pinky.position.y <= SCREEN_SIZE.y * 0.08 - 15) {
      pinky.setDirection(0);
    }
    guzuta.move();
    guzuta.update();
    guzuta.draw();
    if (guzuta.getDirection() == 0 && guzuta.position.x >= SCREEN_SIZE.x / 2 + logoImage.width / 2 + 15) {
      guzuta.setDirection(3);
    } else if (guzuta.getDirection() == 3 && guzuta.position.y >= SCREEN_SIZE.y * 0.08 + logoImage.height + 15) {
      guzuta.setDirection(2);
    } else if (guzuta.getDirection() == 2 && guzuta.position.x <= SCREEN_SIZE.x / 2 - logoImage.width / 2 - 15) {
      guzuta.setDirection(1);
    } else if (guzuta.getDirection() == 1 && guzuta.position.y <= SCREEN_SIZE.y * 0.08 - 15) {
      guzuta.setDirection(0);
    }

    /*
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
     
     if (startCount > 1) {
     akabei.move();
     akabei.update();
     akabei.draw();
     }
     if (startCount > 2) {
     aosuke.move();
     aosuke.update();
     aosuke.draw();
     }
     if (startCount > 3) {
     pinky.move();
     pinky.update();
     pinky.draw();
     }
     if (startCount > 4) {
     guzuta.move();
     guzuta.update();
     guzuta.draw();
     }*/
  }
}