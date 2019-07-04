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
    return keyPressed && key == 'z';
  }

  public boolean buttonB() {
    return keyPressed && key == 'x';
  }
}

// アーケードからの入力
public class ArcadeInput implements InputInterface {
  public boolean right() {
    return keyPressed && key == 'a';
  }

  public boolean up() {
    return keyPressed && key == 'b';
  }

  public boolean left() {
    return keyPressed && key == 'c';
  }

  public boolean down() {
    return keyPressed && key == 'd';
  }

  public boolean buttonA() {
    return keyPressed && key == 'e';
  }

  public boolean buttonB() {
    return keyPressed && key == 'f';
  }
}

// 入力
public static class Input {
  protected static InputInterface inputInterface;

  public static void setInputInterface(InputInterface inputInterface) {
    Input.inputInterface = inputInterface;
  }

  public static boolean right() {
    return inputInterface.right();
  }

  public static boolean up() {
    return inputInterface.up();
  }

  public static boolean left() {
    return inputInterface.left();
  }

  public static boolean down() {
    return inputInterface.down();
  }

  public static boolean buttonA() {
    return inputInterface.buttonA();
  }

  public static boolean buttonB() {
    return inputInterface.buttonB();
  }
}
