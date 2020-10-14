import java.time.*;
import java.time.format.*;
import javax.swing.*;

// リザルト画面
public class Result implements Scene {
  protected int score;     // スコア
  protected int stage;     // ステージ
  protected boolean clear; // クリアしたか
  protected int ranking;   // ランキング
  protected boolean light = true;   // 点灯中か
  protected boolean first = true;   // 初回のループか
  protected boolean regist = false; // ランキング登録するか
  protected Timer lightTimer = new Timer(30);         // タイマー
  protected Timer buttonTimer = new Timer(90, false); // 操作受付タイマー

  // キャラクター
  protected FreeCharacter[] characters = {
    new FreeCharacter(new PVector(292, 765), 3, 0, "player"),
    new FreeCharacter(new PVector(328, 765), 3, 0, "fujix"),
    new FreeCharacter(new PVector(364, 765), 3, 0, "ito"),
    new FreeCharacter(new PVector(400, 765), 3, 0, "arai"),
    new FreeCharacter(new PVector(436, 765), 3, 0, "ohya")
  };

  public Result(int score, int stage, boolean clear) {
    this.score = score;
    this.stage = stage;
    this.clear = clear;
  }

  public void update() {
    // ランキング登録
    if (first) {
      first = false;
      
      // Yes/Noダイアログを表示
      regist = JOptionPane.showConfirmDialog(null, "ランキングにとうろくしますか？", "", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE) == JOptionPane.YES_OPTION;
      
      // Yesが選択されたら
      if (regist) {
        String name;
        
        while (true) {
          // 入力ダイアログを表示
          name = JOptionPane.showInputDialog(null, "なまえをにゅうりょくしてください\n(かんじいがい・10もじいない)");
          
          // 取り消しが押されたら
          if (name == null) {
            return;
          } else if (name.length() == 0) {
            name = "ななしマン";
            break;
          } else if (name.length() <= 10 && name.matches("^[0-9a-zA-Z\\p{InHiragana}\\p{InKatakana}]*$")) {
            break;
          }
        }
        
        // 日時を取得
        LocalDateTime ldt = LocalDateTime.now();
        String datetime = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(ldt);
        
        db.query("INSERT INTO ranking VALUES ('" + name + "', " + score + ", '" + datetime + "')");
        ranking = int(db.query("SELECT COUNT(*) + 1 FROM ranking WHERE score > " + score)[0][0]);
        
      // Noが選択されたら
      } else {
        return;
      }
    }
    
    if (lightTimer.update()) {
      lightTimer.setTime(light ? 15 : 30);
      light = !light;
    }

    for (FreeCharacter character : characters)
      character.update();

    if (buttonTimer.update() && Input.anyButtonPress())
      SceneManager.setScene(new Title());
  }

  public void draw() {
    background(200, 240, 255);
    noStroke();
    rectMode(CENTER);
    textAlign(CENTER, CENTER);

    fill(63, 63, 63);
    rect(SCREEN_SIZE.x / 2, 167, 420, 75);

    fill(255, 255, 255);
    textFont(font2, 60);
    if (clear)
      text("GAME CLEAR!", SCREEN_SIZE.x / 2, 163);
    else
      text("GAME OVER", SCREEN_SIZE.x / 2, 163);

    fill(0, 0, 0);
    text(stage, SCREEN_SIZE.x / 2, 333);
    text(score, SCREEN_SIZE.x / 2, 468);

    fill(0, 0, 159);
    textFont(font2, 40);
    text("ステージ", SCREEN_SIZE.x / 2, 283);
    text("スコア", SCREEN_SIZE.x / 2, 418);

    if (light && regist) {
      fill(127, 127, 127);
      rect(SCREEN_SIZE.x / 2, 580, 320, 60);

      fill(255, 255, 0);
      text("ランキングNo. " + ranking, SCREEN_SIZE.x / 2, 580);
    }

    fill(0, 0, 0);
    text("ボタンをおしてタイトルへ", SCREEN_SIZE.x / 2, 710);

    for (FreeCharacter character : characters)
      character.draw();
  }
}
