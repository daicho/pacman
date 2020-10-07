import java.time.*;
import java.time.format.*;
import javax.swing.*;

void setup() {
  // 獲得スコア(仮)
  int score = int(random(0, 10000));
  
  // 接続先DBは"test", "pacman", "tetris", "unagi"から指定
  DataBase db = new DataBase("test");
  
  // スコア順にソートしてランキングを取得
  String res = db.query("SELECT * FROM ranking ORDER BY score DESC");
  
  // 接続できない場合はnullが返る
  if (res != null && !res.isEmpty()) {
    // ランキングを表示
    String[] ranking = split(res, '\n');
    
    for (String row : ranking) {
      String[] item = split(row, ',');
      println(item[0] + ": " + item[1]);
    }
  }
  
  // 接続できるかチェック
  if (!db.canConnect()) {
    exit(); // タイトルへ戻る処理など
  }
  
  // Yes/Noダイアログを表示
  int regist = JOptionPane.showConfirmDialog(null, "ランキングに登録しますか？", "確認", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
  
  // Yesが選択されたら
  if (regist == JOptionPane.YES_OPTION) {
    // 入力ダイアログを表示
    String name = JOptionPane.showInputDialog(null, "名前を入力してください");
    
    // 取り消しが押されたら
    if (name == null) {
      exit(); // タイトルへ戻る処理など
    }
    
    // 日時を取得
    LocalDateTime ldt = LocalDateTime.now();
    String datetime = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(ldt);
    
    db.query("INSERT INTO ranking VALUES ('" + name + "', " + score + ", '" + datetime + "')"); //<>//
    
  // Noが選択されたら
  } else if (regist == JOptionPane.NO_OPTION) {
    exit(); // タイトルへ戻る処理など
  }
  
  exit();
}
