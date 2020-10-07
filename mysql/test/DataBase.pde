import java.io.*;
import java.net.*;
import http.requests.*;

// データベース操作用クラス
public class DataBase {
  protected String dbname;
  protected String url;
  
  /*
  gameに指定する文字列
  test  : テスト用データベース
  pacman: パックマン
  tetris: テトリス
  unagi : UNAGI
  */
  public DataBase(String dbname) {
    this.dbname = dbname;
    this.url = "https://nitnc5j.sakura.ne.jp/" + dbname + "/mysql/query.php";
  }
  
  // クエリ
  public String query(String sql) {
    // 接続チェック
    if (!canConnect()) {
      return null;
    }
    
    // クエリを実行
    PostRequest post = new PostRequest(url);
    
    try {
      post.addData("query", URLEncoder.encode(sql, "UTF-8"));
    } catch (UnsupportedEncodingException e) {
      
    }
    
    post.send();
    return post.getContent();
  }
  
  // 接続できるかチェック
  public boolean canConnect() {
    try {
      URL obj = new URL(url);
      obj.openConnection().getInputStream();
    } catch (Exception e) {
      return false;
    }
    
    return true;
  }
}
