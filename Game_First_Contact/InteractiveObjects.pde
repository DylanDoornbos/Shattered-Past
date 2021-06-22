class InteractiveObject {

  InventoryItem item;
  float x;
  float y;
  int areaWidth;
  int areaHeight;
  boolean pickUp;
  //public String objectFileA;

  public InteractiveObject (float newX, float newY, 
    int newWidth, int newHeight, 
    String objectFile, boolean canPickUp, String newName) {
    item = new InventoryItem(objectFile, newName);
    x = newX;
    y = newY;
    areaWidth = newWidth;
    areaHeight = newHeight;
    item.objectImage.resize(areaWidth, areaHeight);
    pickUp = canPickUp;
  }
}

// number lock

class LockButton {
  float x;
  float y;
  int w;
  int h;
  int n;
  public LockButton(float lockX, float lockY, int lockW, int lockH, int Number) {
    x = lockX;
    y = lockY;
    w = lockW;
    h = lockH;
    n = Number;
  }
}
