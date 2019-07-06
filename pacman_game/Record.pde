public static class Record {
  protected static int highScore;

  public static int getHighScore() {
    return Record.highScore;
  }

  public static void setHighScore(int score) {
    // scoreがhighScoreより高かったら更新
    Record.highScore = score;
  }

  // ハイスコアの読み込み
  public static void loadHighScore(int score) {
    Record.highScore = score;
  }
}