// 入力のインターフェース
public interface InputInterface {
  public abstract boolean right();   // →
  public abstract boolean up();      // ↑
  public abstract boolean left();    // ←
  public abstract boolean down();    // ↓
  public abstract boolean buttonA(); // A
  public abstract boolean buttonB(); // B
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