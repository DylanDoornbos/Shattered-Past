//basement 1
class SceneBasement_1 extends Scene {

  private boolean firstEntrance = true;

  Dialogue enterSceneDialogue = new Dialogue(new String[]{
    "P: The basement always looks vaguely the same", 
    "P: Some things change, sometimes things are in a different place but there are things that never change, like the portrait on the wall for example!"
    });

  public SceneBasement_1() {
    super("Basement1.png", "Basement", true);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Basement 2", 20, height - 100, 80, 80), 
      new SceneTransitionArea("Portrait", 490, 70, 235, 310), 
      new SceneTransitionArea("Chest", 820, 380, 140, 350)
    };
    //interactiveObjects = new InteractiveObject[]{
    //  new InteractiveObject(200, 200, 50, 50, "placeholder.png", true)
    //};

    InteractiveDialogue candleDialogue1 = new InteractiveDialogue(429, 260, 60, 350, 
      new Dialogue(new String[]{
      "The soft light from the candle illuminates the room"
      }));

    InteractiveDialogue candleDialogue2 = new InteractiveDialogue(730, 260, 60, 350, 
      new Dialogue(new String[]{
      "The soft light from the candle illuminates the room"
      }));

    dialogueObjects = new InteractiveDialogue[]{candleDialogue1, candleDialogue2};
  }

  public void Draw() {
    //Draw the rest of the scene
    super.Draw();

    //Check if it's the first time entering the room
    if (firstEntrance) {
      //Play the dialogue
      enterSceneDialogue.Play();

      //Update the boolean
      firstEntrance = false;
    }

    image(arrowLeftImage, 20, height - 100, 80, 80);
  }
}

class Chest extends Scene {

  public boolean sheetPresent = true;
  private boolean chestLocked = true;

  InteractiveDialogue ChestSheetDialogue = new InteractiveDialogue(95, 167, 900, 532, 
    new Dialogue(new String[]{
    "I took off the white sheet, It's a chest", 
    "P: there was a chest in the corner of the room, but it was locked"
    }));

  InteractiveDialogue chestClosedDialogue = new InteractiveDialogue(95, 167, 900, 532, 
    new Dialogue(new String[]{
    "It seems to be locked"
    }));

  Dialogue unlockChestDialogue = new Dialogue(new String[]{
    "P: The chest opened and I looked inside, it was totally black", 
    "P: I reached my arm in and tried to feel around", 
    "P: Nothing..", 
    "P: I took the sheet from besides me and dropped it in", 
    "P: I watched it slowly drift to the bottom until it hit the ground", 
    "P: It looked to be about 6 feet deep, but for some reason I considered going inside", 
    "The therapist scribbles something on her paper"
    });

  SceneTransitionArea transitionToCloset = new SceneTransitionArea("Closet?", 100, 400, 800, 300);

  public Chest() {
    super ("chest closed sheet.png", "Chest", true);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Basement 1", 40, height - 100, 80, 80)
    };

    // to add key interactivity
    // super ("chest_open.png, "Chest");
  }

  public void Draw() {
    super.Draw();
    image(arrowBackImage, 40, height - 100, 80, 80);
  }

  public void MouseHover() {
    boolean hover = false;
    if (sheetPresent) {
      //If clicked on the sheet
      if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, ChestSheetDialogue.x, ChestSheetDialogue.y, ChestSheetDialogue.areaWidth, ChestSheetDialogue.areaHeight)) {
        hover = true;
      }
    } //Else if the sheet is gone and the chest is locked
    else if (chestLocked) {
      //If clicked on the locked chest
      if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, chestClosedDialogue.x, chestClosedDialogue.y, chestClosedDialogue.areaWidth, chestClosedDialogue.areaHeight)) {
        hover = true;
      }
    } //Else if the chest is open
    else if (!chestLocked) {
      if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, transitionToCloset.x, transitionToCloset.y, transitionToCloset.areaWidth, transitionToCloset.areaHeight)) {
        hover = true;
      }
    }

    if (hover) {
      cursor(HAND);
    } else {
      super.MouseHover();
    }
  }

  public void MouseClicked() {
    //If the sheet is present
    if (sheetPresent) {
      //If clicked on the sheet
      if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, ChestSheetDialogue.x, ChestSheetDialogue.y, ChestSheetDialogue.areaWidth, ChestSheetDialogue.areaHeight)) {
        //Play the dialogue
        ChestSheetDialogue.dialogueToDisplay.Play();

        //Play the cloth sound
        clothSound.play();

        //Remove the sheet
        sheetPresent = false;
        background_Image = loadImage("chest closed.png");

        //Change the basement_1 scene's background
        //If the key was picked up
        if (portrait.keyPickedUp) {
          basement_1.background_Image = loadImage("Basement1 no sheet no key.png");
        } //Else if the key was not picked up
        else {
          Game_First_Contact.basement_1.background_Image = loadImage("Basement1 no sheet.png");
        }
      }
    } //Else if the sheet is gone and the chest is locked
    else if (chestLocked) {
      //If clicked on the locked chest
      if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, chestClosedDialogue.x, chestClosedDialogue.y, chestClosedDialogue.areaWidth, chestClosedDialogue.areaHeight)) {
        //If the key is selected
        if (Game_First_Contact.selectedItem != null && Game_First_Contact.selectedItem.itemName == "Chest Key") {
          //Play the "unlock" dialogue
          unlockChestDialogue.Play();

          //Play the unlock chest sound
          Game_First_Contact.chestUnlockSound.play();

          //Unlock the chest
          chestLocked = false;
          background_Image = loadImage("Chest open.png");

          //Remove the key from the inventory
          Game_First_Contact.UseItem();
        } //If the key wasn't selected
        else {
          //Play the flavour text
          chestClosedDialogue.dialogueToDisplay.Play();
        }
      }
    } //Else if the chest is open
    else if (!chestLocked) {
      if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, transitionToCloset.x, transitionToCloset.y, transitionToCloset.areaWidth, transitionToCloset.areaHeight)) {
        ChangeScene(transitionToCloset.destinationScene);
      }
    }

    super.MouseClicked();
  }
}

class Portrait extends Scene {
  boolean puzzleSolved = false;
  public boolean keyPickedUp = false;
  boolean firstEntrance = true;
  boolean distortedPainting = false;

  private InteractiveObject itemKey = new InteractiveObject(441, 462, 70, 70, "key.png", true, "Chest Key");

  private InventoryItem[] placedPictures = new InventoryItem[4];
  private InteractiveDialogue[] pictureFrames;

  private Dialogue sceneEnterConversation = new Dialogue(new String[]{
    "It's a portrait of a young girl with a key necklace", 
    "P: The portrait on the wall was always something I looked at first, it captivated me in a way that is hard to describe", 
    "T: Do you recognize the painting?", 
    "P: Yes, it's a portrait of my sister..", 
    "T: You sound surprised", 
    "P: She's been dead for years.\nMom said she got ill but I'm starting to question it..", 
    "T: Interesting. Please continue"
    });

  private Dialogue picturesWrongOrderDialogue = new Dialogue(new String[]{
    "Nothing happened"
    });

  private Dialogue picturesCorrectOrderDialogue = new Dialogue(new String[]{
    "P: As I put the last piece in place the world warped before me, the portrait seemed to melt as the world spun", 
    "P: I looked back at the picture only to see my own reflection, and the key still floating in the middle of the painting", 
    "P: I felt the urge to grab it"
    });

  private Dialogue pickUpKeyDialogue = new Dialogue(new String[]{
    "P: I reached out and I could feel the key in my hand"
    });

  InteractiveDialogue portraitDialogue = new InteractiveDialogue(277, 40, 440, 575, 
    new Dialogue(new String[]{
    "It's a portrait of a young girl with a key necklace"
    }));

  public Portrait() {
    super ("portrait.png", "Portrait", true);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Basement 1", 40, height - 100, 80, 80)
    };

    InteractiveDialogue pictureFrame1 = new InteractiveDialogue(190, 650, 149, 100, 
      new Dialogue(new String[]{
      "It's a picture frame"
      }));
    InteractiveDialogue pictureFrame2 = new InteractiveDialogue(348, 651, 149, 100, 
      new Dialogue(new String[]{
      "It's a picture frame"
      }));
    InteractiveDialogue pictureFrame3 = new InteractiveDialogue(502, 650, 149, 100, 
      new Dialogue(new String[]{
      "It's a picture frame"
      }));
    InteractiveDialogue pictureFrame4 = new InteractiveDialogue(667, 649, 149, 100, 
      new Dialogue(new String[]{
      "It's a picture frame"
      }));

    pictureFrames = new InteractiveDialogue[]{pictureFrame1, pictureFrame2, pictureFrame3, pictureFrame4};
  }

  public void Draw() {
    super.Draw();

    image(arrowBackImage, 40, height - 100, 80, 80);

    //Play the conversation if it's the first time you enter this scene
    if (firstEntrance) {
      sceneEnterConversation.Play();
      firstEntrance = false;
    }

    //For each placed picture
    for (int i = 0; i < placedPictures.length; i++) {
      if (placedPictures[i] != null) {
        //Draw the picture in the scene
        image(placedPictures[i].objectImage, pictureFrames[i].x, pictureFrames[i].y, pictureFrames[i].areaWidth, pictureFrames[i].areaHeight);
      }
    }

    //If the puzzle is solved and the key hasn't been picked up yet
    if (puzzleSolved && !keyPickedUp && distortedPainting) {
      //Draw the key in the scene
      image(itemKey.item.objectImage, itemKey.x, itemKey.y, itemKey.areaWidth, itemKey.areaHeight);
    }
  }

  public void MouseHover() {
    boolean hovered = false;

    if (!puzzleSolved) {
      //Check if the portrait was hovered over
      if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, portraitDialogue.x, portraitDialogue.y, portraitDialogue.areaWidth, portraitDialogue.areaHeight)) {
        hovered = true;
      }

      //For each picture frame
      for (int i = 0; i < pictureFrames.length; i++) {
        //If the user hovered over the picture frame
        if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, pictureFrames[i].x, pictureFrames[i].y, pictureFrames[i].areaWidth, pictureFrames[i].areaHeight)) {
          hovered = true;
        }
      }
    } else if (puzzleSolved && !keyPickedUp && distortedPainting) {
      if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, itemKey.x, itemKey.y, itemKey.areaWidth, itemKey.areaHeight)) {
        hovered = true;
      }
    }

    if (hovered) {
      cursor(HAND);
    } else {
      super.MouseHover();
    }
  }

  public void MouseClicked() {
    //If the puzzles hasn't been solved
    if (!puzzleSolved) {
      //Check if the portrait was clicked
      if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, portraitDialogue.x, portraitDialogue.y, portraitDialogue.areaWidth, portraitDialogue.areaHeight)) {
        portraitDialogue.dialogueToDisplay.Play();
      }

      //For each picture frame
      for (int i = 0; i < pictureFrames.length; i++) {
        //If the user clicked on the picture frame
        if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, pictureFrames[i].x, pictureFrames[i].y, pictureFrames[i].areaWidth, pictureFrames[i].areaHeight)) {
          //If an inventory item was selected and the clicked frame is empty
          if (Game_First_Contact.selectedItem != null && placedPictures[i] == null) {

            //If one of the pictures was selected
            switch(Game_First_Contact.selectedItem.itemName) {
            case "Picture 1":
            case "Picture 2":
            case "Picture 3":
            case "Picture 4":
              //Add the picture to the list of placed pictures, depending on which frame you clicked
              placedPictures[i] = Game_First_Contact.selectedItem;
              //Remove the placed picture from the player's inventory
              for (int p = 0; p < Game_First_Contact.inventory.size(); p++) {
                if (Game_First_Contact.inventory.get(p) == Game_First_Contact.selectedItem) {
                  Game_First_Contact.UseItem();
                }
              }
              ;
              break;
            }
          } //Else if the picture frame was not empty
          else if (placedPictures[i] != null) {
            //Pick the picture back up
            Game_First_Contact.inventory.add(placedPictures[i]);
            placedPictures[i] = null;
          } //Else if the picture frame is empty, but no picture was selected
          else if (placedPictures[i] == null && Game_First_Contact.selectedItem == null) {
            pictureFrames[i].dialogueToDisplay.Play();
          }


          boolean isFull = true;
          //Check if all 4 pictures are in place
          for (int c = 0; c < placedPictures.length; c++) {
            //If the pictureFrame is empty, set isFull to false
            if (placedPictures[c] == null) {
              isFull = false;
            }
          }

          //If all pictures are placed
          if (isFull) {

            boolean isCorrect = true;

            //check if the pictures are in the correct spot
            for (int c = 0; c < placedPictures.length; c++) {
              //If the picture is in the wrong spot
              if (!placedPictures[c].itemName.equals("Picture " + (c + 1))) {
                //Show the "nothing happened" dialogue
                picturesWrongOrderDialogue.Play();

                isCorrect = false;

                //Place all pictures back in the inventory
                for (int b = 0; b < placedPictures.length; b++) {
                  Game_First_Contact.inventory.add(placedPictures[b]);
                  placedPictures[b] = null;
                }
                break;
              }
            }

            //If the pictures are in the correct order
            if (isCorrect) {
              //Play the "correct order" dialogue
              picturesCorrectOrderDialogue.Play();

              //Set the puzzle to solved
              puzzleSolved = true;

              //Set the painting to distorted
              distortedPainting = true;



              //Change the background
              background_Image = loadImage("portrait faded.png");
            }
          }
        }
      }
    } //If the puzzle is solved
    else if (puzzleSolved) {
      //If the key isn't picked up yet
      if (!keyPickedUp) {
        //If the player clicked on the key
        if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, itemKey.x, itemKey.y, itemKey.areaWidth, itemKey.areaHeight)) {
          //Change the background
          background_Image = loadImage("portrait no key.png");

          //Set key picked up to true
          keyPickedUp = true;

          //Add the key to the inventory
          Game_First_Contact.inventory.add(itemKey.item);

          //Play the key pick up dialogue
          pickUpKeyDialogue.Play();

          //Change the background of the basement_1 scene
          //If the sheet is still on the chest
          if (chest.sheetPresent) {
            basement_1.background_Image = loadImage("Basement1 no key.png");
          } //Else if the sheet was removed
          else {
            basement_1.background_Image = loadImage("Basement1 no sheet no key.png");
          }

          distortedPainting = false;
        }
      }
    }

    super.MouseClicked();
  }
}
//basement 2

class SceneBasement_2 extends Scene {

  private boolean firstEntrance = true;

  private Dialogue sceneEnterConversation = new Dialogue(new String[]{
    "P: The bookshelf itself isn't always here, but the books are, they are usually filled with pictures of me, my sister, my mom and I think my father.", 
    "T: You think?", 
    "P: I don't remember much about him"
    });

  public SceneBasement_2() {
    super("Basement2.png", "Basement", true);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Basement 1", width - 100, height - 100, 80, 80), 
      new SceneTransitionArea("Photo Album", 483, 666, 120, 104), 
    };
  }

  public void Draw() {
    super.Draw();
    image(arrowRightImage, width - 100, height - 100, 80, 80);

    //Play the conversation if it's the first time you enter this scene
    if (firstEntrance) {
      sceneEnterConversation.Play();
      firstEntrance = false;
    }
  }
}

class Album extends Scene {
  private boolean firstEntrance = true;
  private ArrayList<InteractiveObject> pictures = new ArrayList<InteractiveObject>();

  private Dialogue sceneEnterConversation = new Dialogue(new String[]{
    "There's a book laying on the ground", 
    "It's a picture book of me and my family"
    });

  public Album() {
    super ("picture book.png", "Photo Album", true);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Basement 2", 30, height - 100, 80, 80)
    };

    pictures.add(new InteractiveObject(177, 422, 280, 188, "picture 1.png", true, "Picture 1"));
    pictures.add(new InteractiveObject(176, 230, 280, 188, "picture 2.png", true, "Picture 2"));
    pictures.add(new InteractiveObject(503, 417, 280, 188, "picture 3.png", true, "Picture 3"));
    pictures.add(new InteractiveObject(496, 219, 280, 188, "picture 4.png", true, "Picture 4"));
  }

  public void Draw() {
    super.Draw();

    image(arrowBackImage, 30, height - 100, 80, 80);

    for (int i = 0; i < pictures.size(); i++) {
      image(pictures.get(i).item.objectImage, pictures.get(i).x, pictures.get(i).y);
    }

    //Play the conversation if it's the first time you enter this scene
    if (firstEntrance) {
      sceneEnterConversation.Play();
      firstEntrance = false;
    }
  }

  public void MouseHover() {
    boolean hovering = false;

    for (int i = 0; i < pictures.size(); i++) {
      if (CheckPointOnBoxCollision(mouseX, mouseY, pictures.get(i).x, pictures.get(i).y, pictures.get(i).areaWidth, pictures.get(i).areaHeight)) {
        hovering = true;
      }
    }

    if (hovering) {
      cursor(HAND);
    } else {
      super.MouseHover();
    }
  }

  public void MouseClicked() {
    //For each picture
    for (int i = 0; i < pictures.size(); i++) {
      //If the user clicked on the picture
      if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, pictures.get(i).x, pictures.get(i).y, pictures.get(i).areaWidth, pictures.get(i).areaHeight)) {
        //Play the paper rip sound file
        paperRipSound.play();

        //Add the picture to the inventory
        Game_First_Contact.inventory.add(pictures.get(i).item);

        //Remove the picture from the list
        pictures.remove(i);
      }
    }

    super.MouseClicked();
  }
}
