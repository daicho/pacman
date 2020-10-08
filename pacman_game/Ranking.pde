import java.io.*;
import java.net.*;
import http.requests.*;

// スコアの記録
public static class Record {
  public static final int RANK_NUM = 10; // ランキングの数

  protected static int[] ranking = new int[RANK_NUM]; // ランキング
  public static String filePath; // ランキングファイルパス

  // 指定されたランクのスコアを返す (+なら上から、-なら下からの順位を参照)
  public static int getRanking(int rank) {
    if (0 < rank && rank <= RANK_NUM)
      return ranking[rank - 1];
    else if (-RANK_NUM <= rank && rank < 0)
      return ranking[RANK_NUM + rank];
    else
      return 0;
  }

  // ランキングに設定する
  public static int setRanking(int score) {
    for (int i = 0; i < RANK_NUM; i++) {
      if (score >= Record.ranking[i]) {
        // ランキングをずらす
        for (int j = RANK_NUM - 1; j > i; j--)
          Record.ranking[j] = Record.ranking[j - 1];

        ranking[i] = score;
        saveRanking();

        return i + 1;
      }
    }

    return 0;
  }

  // ファイルパス設定
  public static void setFilePath(String filePath) {
    Record.filePath = filePath;
    loadRanking();
  }

  // ハイスコアの読み込み
  public static void loadRanking() {
    String[] scoreData = loadStrings(new File(filePath)); // ハイスコアをロード

    for (int i = 0; i < RANK_NUM; i++) {
      int score = int(scoreData[i]);
      Record.ranking[i] = score;
    }
  }

  // ハイスコアの保存
  public static void saveRanking() {
    String[] scoreData = new String[RANK_NUM];
    for (int i = 0; i < RANK_NUM; i++) {
      scoreData[i] = str(ranking[i]);
    }

    saveStrings(new File(filePath), scoreData);
  }
}

// オンラインでスコアの記録
public static class RecordOnline {
  protected static DataBase db = new DataBase("pacman"); // データベース

  // 指定されたランクのスコアを返す (+なら上から、-なら下からの順位を参照)
  public static int getRanking(int rank) {
    if (0 < rank && rank <= RANK_NUM)
      return ranking[rank - 1];
    else if (-RANK_NUM <= rank && rank < 0)
      return ranking[RANK_NUM + rank];
    else
      return 0;
  }

  // ランキングに設定する
  public static int setRanking(int score) {
    for (int i = 0; i < RANK_NUM; i++) {
      if (score >= Record.ranking[i]) {
        // ランキングをずらす
        for (int j = RANK_NUM - 1; j > i; j--)
          Record.ranking[j] = Record.ranking[j - 1];

        ranking[i] = score;
        saveRanking();

        return i + 1;
      }
    }

    return 0;
  }

  // ファイルパス設定
  public static void setFilePath(String filePath) {
    Record.filePath = filePath;
    loadRanking();
  }

  // ハイスコアの読み込み
  public static void loadRanking() {
    String[] scoreData = loadStrings(new File(filePath)); // ハイスコアをロード

    for (int i = 0; i < RANK_NUM; i++) {
      int score = int(scoreData[i]);
      Record.ranking[i] = score;
    }
  }

  // ハイスコアの保存
  public static void saveRanking() {
    String[] scoreData = new String[RANK_NUM];
    for (int i = 0; i < RANK_NUM; i++) {
      scoreData[i] = str(ranking[i]);
    }

    saveStrings(new File(filePath), scoreData);
  }
}

// データベース操作
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
