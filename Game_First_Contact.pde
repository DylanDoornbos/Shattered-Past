import processing.sound.*;

//create basement rooms
public static SceneStart start;
public static Scene activeScene;
public static SceneBasement_1 basement_1;
public static SceneBasement_2 basement_2;
public static Chest chest;
public static Portrait portrait;
public static Album album;

//create bedroom rooms
public static Closet closet;
public static Bedroom1 bedroom1;
public static Bedroom2 bedroom2;
public static Diary diary;
public static DiaryPage diaryPage;
public static DiaryPage2 diaryPage2;
public static DiaryPage3 diaryPage3;
public static DoorLock doorLock;
public static Camera1 camera1;
public static Camera2 camera2;
public static Teddy teddy;
public static Book book;

//create hallways
public static Hallway1 hallway1;
public static Hallway2 hallway2;
public static Outside outside;
public static Credits credits;

//create offices
public static Office1 office1;
public static Office2 office2;

//Create sound files
public static SoundFile chestUnlockSound;
public static SoundFile paperRipSound;
public static SoundFile clothSound;
public static SoundFile mainTheme;
public static SoundFile denied;
public static SoundFile keypadPress;
public static SoundFile accepted;
public static SoundFile yeet;

//Create font
PFont font;

//create inventory
public static boolean displayInventory;
public static InventoryItem selectedItem;
public static PImage inventoryImage;

public static ArrayList <InventoryItem> inventory = new ArrayList<InventoryItem>();

//Scene transitions
private static Scene sceneToChangeTo;
private static boolean changingScene;
private static boolean fadingOut;
private static float sceneTransitionSpeed = 15;
private static int sceneDarkness = 0;

public static PImage arrowBackImage;
public static PImage arrowRightImage;
public static PImage arrowLeftImage;

//Dialogue stuff
public static boolean dialogueActive = false;
public static Dialogue activeDialogue;
public static PImage dialogueBoxImage;
public static PImage nameBoxImage;

void setup() {
  size(1000, 800);
  surface.setTitle("Shattered Past");

  fill(#1a110c);
  rect(0, 0, width, height);
  textAlign(CENTER, CENTER);
  fill(#624e30);
  textSize(25);
  text("LOADING...", width / 2, height / 2);

  font = createFont("OptimusPrincepsSemiBold.ttf", 1);
  textFont(font);

  dialogueBoxImage = loadImage("dialogue box.png");
  nameBoxImage = loadImage("name box.png");
  inventoryImage = loadImage("inventory.png");
  arrowBackImage = loadImage("arrow back.png");
  arrowRightImage = loadImage("arrow right.png");
  arrowLeftImage = loadImage("arrow left.png");

  chestUnlockSound = new SoundFile(this, "chest unlock.mp3");
  paperRipSound = new SoundFile(this, "paper rip.mp3");
  clothSound = new SoundFile(this, "cloth.mp3");
  mainTheme = new SoundFile(this, "main_theme.mp3");
  denied = new SoundFile(this, "keypad_denied.mp3");
  keypadPress = new SoundFile(this, "keypad_press.mp3");
  accepted = new SoundFile(this, "keypad_granted.mp3");
  yeet = new SoundFile(this, "yeet.mp3");

  start = new SceneStart();
  basement_1 = new SceneBasement_1();
  basement_2 = new SceneBasement_2();
  chest = new Chest();
  portrait = new Portrait();
  album = new Album();
  closet = new Closet();
  bedroom1 = new Bedroom1();
  bedroom2 = new Bedroom2();
  diary = new Diary();
  diaryPage = new DiaryPage();
  diaryPage2 = new DiaryPage2();
  diaryPage3 = new DiaryPage3();
  doorLock = new DoorLock();
  hallway1 = new Hallway1();
  hallway2 = new Hallway2();
  office1 = new Office1();
  office2 = new Office2();
  camera1 = new Camera1();
  camera2 = new Camera2();
  teddy = new Teddy();
  book = new Book();
  outside = new Outside();
  credits = new Credits();
  activeScene = start;
  
  mainTheme.amp(0.3);
  mainTheme.loop();
}

void draw() {  
  //draw the actice scene
  activeScene.Draw();

  //If changing the scene
  if (changingScene) {

    //Change the mouse cursor to an arrow
    cursor(ARROW);

    //If fading out
    if (fadingOut) {
      //raise the scene darkness
      sceneDarkness += sceneTransitionSpeed;
      //If the scene comepletely faded out
      if (sceneDarkness >= 255) {
        sceneDarkness = 255;

        //Stop fading out
        fadingOut = false;

        //Change the scene
        activeScene = sceneToChangeTo;

        displayInventory = activeScene.allowInventory;
      }
    } //Else if not fading out
    else {
      //Lower the scene darkness
      sceneDarkness -= sceneTransitionSpeed;

      //If the sceneOpacity is full
      if (sceneDarkness <= 0) {
        sceneDarkness = 0;

        //Stop changing the scene
        changingScene = false;
      }
    }
  } //Else if not changing the scene
  else {
    //If there is an active dialogue box
    if (dialogueActive) {
      //Draw the dialogue
      activeDialogue.Draw();

      //Check for mouse hover in the dialogue
      activeDialogue.MouseHover();
    } else {
      //Check for mouse hover in the scene
      activeScene.MouseHover();
    }
  }

  //display the inventory

  if (displayInventory) {
    inventoryDisplay();
  }

  //Draw a coloured rectangle based on scene Opacity
  fill(0, 0, 0, sceneDarkness);
  rect(0, 0, width, height);
}

void mouseClicked() {
  //Only run this code if we're not changing scene
  if (!changingScene) {

    if (dialogueActive) {
      //Click in the dialogue box
      activeDialogue.MouseClicked();
    } //If there is no dialogue box active
    else {
      //Click inside the scene
      activeScene.MouseClicked();
    }
  }
}

//Check for collision between a single point and a rectangle/box
public static boolean CheckPointOnBoxCollision(float pointX, float pointY, 
  float targetX, float targetY, 
  float targetWidth, float targetHeight) {
  if (pointX >= targetX
    && pointX <= targetX + targetWidth
    && pointY >= targetY
    && pointY <= targetY + targetHeight) {
    return true;
  }

  return false;
}

void mousePressed() {
  //Only run this code if we're not changing scene
  if (!changingScene) {
    if (activeScene.scene_Name == "Door Lock") {
      doorLock.lockPuzzle();
    }
    if (inventory != null && displayInventory) {
      for (int i = 0; i<inventory.size(); i++) {
        //mouse hovers over?
        if (CheckPointOnBoxCollision(mouseX, mouseY, 
          21, 190+(100*i), 67, 63)) {
          // if yes, change cursor
          selectedItem = inventory.get(i);


          return;
        }
      }
    }
  }
}


public static void ChangeScene(String newScene) {

  //Indicate that we're changing scenes
  changingScene = true;

  //Indicate that we're fading out
  fadingOut = true;

  //Switch to the requested scene
  switch(newScene) {
  case "Start":
    sceneToChangeTo = start;
    break;
  case "Basement 1":
    sceneToChangeTo = basement_1;
    break;
  case "Basement 2":
    sceneToChangeTo = basement_2;
    break;
  case "Chest":
    sceneToChangeTo = chest;
    break;
    //case "Chest Open":
    //  activeScene = chestOpen;
    //  break;
  case "Portrait":
    sceneToChangeTo = portrait;
    break;
  case "Photo Album":
    sceneToChangeTo = album;
    break;
  case "Closet?":
    sceneToChangeTo = closet;
    break;
  case "Bedroom 1":
    sceneToChangeTo = bedroom1;
    break;
  case "Bedroom 2":
    sceneToChangeTo = bedroom2;
    break;
  case "Diary":
    sceneToChangeTo = diary;
    break;
  case "Diary page":
    sceneToChangeTo = diaryPage;
    break;
  case "Diary page 2":
    sceneToChangeTo = diaryPage2;
    break;
  case "Diary page 3":
    sceneToChangeTo = diaryPage3;
    break;
  case "Door Lock":
    sceneToChangeTo = doorLock;
    break;
  case "Hallway":
    sceneToChangeTo = hallway1;
    break;
  case "Hallway 2":
    sceneToChangeTo = hallway2;
    break;
  case "Office 1":
    sceneToChangeTo = office1;
    break;
  case "Teddy":
    sceneToChangeTo = teddy;
    break;
  case "Camera front":
    sceneToChangeTo = camera1;
    break;
  case "Camera back":
    sceneToChangeTo = camera2;
    break;
  case "Book":
    sceneToChangeTo = book;
    break;
  case "Outside":
    sceneToChangeTo = outside;
    break;
  case "   ":
    sceneToChangeTo = credits;
    break;
  case "Office ":
    sceneToChangeTo = office2;
    break;
  }
}

void inventoryDisplay() {
  //fill(255, 255, 0);
  //rect(0, 200, 75, height - 400);

  image(inventoryImage, 0, 0);

  //show items
  for (int i = 0; i<inventory.size(); i++) {
    if (selectedItem != null && inventory.get(i) == selectedItem) {
      tint(#ff8080);
    }
    
    image(inventory.get(i).inventoryImage, 21, 190+(100*i), 67, 63);
    
    tint(255, 255, 255);
  }

  if (inventory != null) {
    for (int i = 0; i<inventory.size(); i++) {
      //mouse hovers over && not dragging an item?
      if (CheckPointOnBoxCollision(mouseX, mouseY, 
        21, 190+(100*i), 67, 63)) {
        // if yes, change cursor and stop checking
        cursor(HAND);
        return;
      }
    }
  }
}

static void UseItem() {
  for (int i = 0; i < inventory.size(); i++) {
    if (selectedItem != null && inventory.get(i) == selectedItem) {
      inventory.remove(i);
      selectedItem = null;
    }
  }
}
