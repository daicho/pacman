import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.swing.JOptionPane;
import http.requests.*;

void setup() {
  int score = 500; // 獲得スコア(仮)
  
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
    String datetime = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(LocalDateTime.now());
    
    // 接続先URLを指定
    String url = "https://nitnc5j.sakura.ne.jp/test/mysql/query.php";
    // PACMAN  : "https://nitnc5j.sakura.ne.jp/pacman/mysql/query.php";
    // テトリス: "https://nitnc5j.sakura.ne.jp/tetris/mysql/query.php"
    // UNAGI   : "https://nitnc5j.sakura.ne.jp/unagi/mysql/query.php"
    
    // サーバーに接続
    PostRequest post = new PostRequest(url);
    
    // SQL文を書く
    post.addHeader("Content-Type", "application/x-www-form-urlencoded; charset=Shift_JIS");
    post.addData("query", "INSERT INTO ranking VALUES ('" + name + "', " + score + ", '" + datetime + "')");
    post.send(); //<>//
    
    // ここに結果が返ってくる
    println(post.getContent());
    
  // Noが選択されたら
  } else if (regist == JOptionPane.NO_OPTION) {
    exit(); // タイトルへ戻る処理など
  }
  
  exit();
}
