// 入力のインターフェース
public abstract class InputInterface {
  public boolean prevRight = false;
  public boolean prevUp = false;
  public boolean prevLeft = false;
  public boolean prevDown = false;
  public boolean prevButtonA = false;
  public boolean prevButtonB = false;

  public abstract boolean right();   // →
  public abstract boolean up();      // ↑
  public abstract boolean left();    // ←
  public abstract boolean down();    // ↓
  public abstract boolean buttonA(); // A
  public abstract boolean buttonB(); // B

  public boolean rightPress() {
    return right();
  }

  public boolean upPress() {
    return up();
  }

  public boolean leftPress() {
    return left();
  }

  public boolean downPress() {
    return down();
  }

  public boolean buttonAPress() {
    return buttonA();
  }

  public boolean buttonBPress() {
    return buttonB();
  }

  public boolean rightRelease() {
    return right();
  }

  public boolean upRelease() {
    return up();
  }

  public boolean leftRelease() {
    return left();
  }

  public boolean downRelease() {
    return down();
  }

  public boolean buttonARelease() {
    return buttonA();
  }

  public boolean buttonBRelease() {
    return buttonB();
  }
}

// キーボードからの入力
public class KeyboardInput extends InputInterface {
  public boolean right() {
    if (keyPressed && keyCode == RIGHT) {
      return true;
    } else {
      return false;
    }
  }

  public boolean up() {
    if (keyPressed && keyCode == UP) {
      return true;
    } else {
      return false;
    }
  }

  public boolean left() {
    if (keyPressed && keyCode == LEFT) {
      return true;
    } else {
      return false;
    }
  }

  public boolean down() {
    if (keyPressed && keyCode == DOWN) {
      return true;
    } else {
      return false;
    }
  }

  public boolean buttonA() {
    if (keyPressed && key == 'z') {
      return true;
    } else {
      return false;
    }
  }

  public boolean buttonB() {
    if (keyPressed && key == 'x') {
      return true;
    } else {
      return false;
    }
  }
}

// アーケードからの入力
public class ArcadeInput extends InputInterface {
  public boolean right() {
    if (keyPressed && key == 'a') {
      return true;
    } else {
      return false;
    }
  }

  public boolean up() {
    if (keyPressed && key == 'b') {
      return true;
    } else {
      return false;
    }
  }

  public boolean left() {
    if (keyPressed && key == 'c') {
      return true;
    } else {
      return false;
    }
  }

  public boolean down() {
    if (keyPressed && key == 'd') {
      return true;
    } else {
      return false;
    }
  }

  public boolean buttonA() {
    if (keyPressed && key == 'e') {
      return true;
    } else {
      return false;
    }
  }

  public boolean buttonB() {
    if (keyPressed && key == 'f') {
      return true;
    } else {
      return false;
    }
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

  public static boolean rightPress() {
    return inputInterface.rightPress();
  }

  public static boolean upPress() {
    return inputInterface.upPress();
  }

  public static boolean leftPress() {
    return inputInterface.leftPress();
  }

  public static boolean downPress() {
    return inputInterface.downPress();
  }

  public static boolean buttonAPress() {
    return inputInterface.buttonAPress();
  }

  public static boolean buttonBPress() {
    return inputInterface.buttonBPress();
  }

  public static boolean rightRelease() {
    return inputInterface.rightRelease();
  }

  public static boolean upRelease() {
    return inputInterface.upRelease();
  }

  public static boolean leftRelease() {
    return inputInterface.leftRelease();
  }

  public static boolean downRelease() {
    return inputInterface.downRelease();
  }

  public static boolean buttonARelease() {
    return inputInterface.buttonARelease();
  }

  public static boolean buttonBRelease() {
    return inputInterface.buttonBRelease();
  }
}
