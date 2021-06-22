class InventoryItem {
  public PImage objectImage;
  public PImage inventoryImage;
  public String itemName;

  public InventoryItem(String objectFile, String newName) {
    //objectFileA = objectFile;
    objectImage = loadImage(objectFile);
    inventoryImage = loadImage(objectFile);
    inventoryImage.resize(67, 63);
    itemName = newName;
  }
}
