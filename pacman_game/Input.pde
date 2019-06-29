// 入力のインターフェース
public interface InputInterface {
  public boolean right();   // →
  public boolean up();      // ↑
  public boolean left();    // ←
  public boolean down();    // ↓
  public boolean buttonA(); // A
  public boolean buttonB(); // B
}

// キーボードからの入力
public class KeyboardInput implements InputInterface {
  public boolean right() {
    return keyPressed && keyCode == RIGHT;
  }

  public boolean up() {
    return keyPressed && keyCode == UP;
  }

  public boolean left() {
    return keyPressed && keyCode == LEFT;
  }

  public boolean down() {
    return keyPressed && keyCode == DOWN;
  }

  public boolean buttonA() {
    return keyPressed && keyCode == 'Z';
  }

  public boolean buttonB() {
    return keyPressed && keyCode == 'X';
  }
}

// アーケードからの入力
public class ArcadeInput implements InputInterface {
  public boolean right() {
    return keyPressed && keyCode == 'A';
  }

  public boolean up() {
    return keyPressed && keyCode == 'B';
  }

  public boolean left() {
    return keyPressed && keyCode == 'C';
  }

  public boolean down() {
    return keyPressed && keyCode == 'D';
  }

  public boolean buttonA() {
    return keyPressed && keyCode == 'E';
  }

  public boolean buttonB() {
    return keyPressed && keyCode == 'F';
  }
}