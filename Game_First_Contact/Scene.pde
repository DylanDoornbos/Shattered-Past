class Scene { // mostly code made by Dylan //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//

  //scene info

  public PImage background_Image;
  public String scene_Name;
  public SceneTransitionArea[] transitionAreas; //list of transition areas
  public ArrayList<InteractiveObject>interactiveObjects = new ArrayList<InteractiveObject>();
  // public InteractiveObject[] interactiveObjects;//list of objects that are interactive (added by Izabella)
  public InteractiveDialogue[] dialogueObjects;//list of objects that start dialogue
  public boolean allowInventory;
  public LockButton[] buttons;

  //scene constructor
  public Scene(String background_File, String newSceneName, boolean sceneAllowInventory) {

    //load backgriun image from a file
    background_Image = loadImage(background_File);

    //make sure image fits screen
    background_Image.resize(1000, 800);

    //set scene name
    scene_Name = newSceneName;
    
    allowInventory = sceneAllowInventory;
  }

  //draw the scene
  public void Draw() {
    //show background image
    image(background_Image, 0, 0, 1000, 800);

    //name of the scene display
    fill(255);
    textSize(20);
    textAlign(CENTER, TOP);
    text(scene_Name, width/2, 10);

    //overlay to test transition scenes
    fill(0, 255, 0, 100);
    noStroke();
    if (transitionAreas != null) {
      //For every Transition Area...
      for (int i = 0; i < transitionAreas.length; i++) {
        //Draw a rect overlay.
        //rect(transitionAreas[i].x, transitionAreas[i].y, transitionAreas[i].areaWidth, transitionAreas[i].areaHeight);
      }
    }

    //overlay to test dialogue objects
    fill(0, 0, 255, 100);
    noStroke();
    if (dialogueObjects != null) {
      //For every dialogue object
      for (int i = 0; i < dialogueObjects.length; i++) {
        //Draw a rect overlay
        //rect(dialogueObjects[i].x, dialogueObjects[i].y, dialogueObjects[i].areaWidth, dialogueObjects[i].areaHeight);
      }
    }
    
    //buttons
     fill(0, 255, 255, 100);
     stroke(0);
    if (buttons != null) {
      //For every dialogue object
      for (int i = 0; i < buttons.length; i++) {
        //Draw a rect overlay
        //rect(buttons[i].x, buttons[i].y, buttons[i].w, buttons[i].h);
      }
    }


    //array list
    //display objects
    if (interactiveObjects != null) {
      for (int i = 0; i<interactiveObjects.size(); i++) {
        image(interactiveObjects.get(i).item.objectImage, interactiveObjects.get(i).x, interactiveObjects.get(i).y);
      }
    }
   

    fill (255, 0, 0, 100);
    noStroke();
    //are there interactive objects?
    if (interactiveObjects != null) {
      //every object
      for (int i = 0; i<interactiveObjects.size(); i++) {
        //rect overlay
        rect(interactiveObjects.get(i).x, interactiveObjects.get(i).y, interactiveObjects.get(i).areaWidth, interactiveObjects.get(i).areaHeight);
      }
    }
  }  


  public void MouseClicked() {
    //are there transitions?
    if (transitionAreas != null) {
      //every transition area
      for (int i = 0; i< transitionAreas.length; i++) {
        // did user click??
        if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, 
          transitionAreas[i].x, 
          transitionAreas[i].y, 
          transitionAreas[i].areaWidth, 
          transitionAreas[i].areaHeight)) {
          //change scene if transition was clicked
          Game_First_Contact.ChangeScene(transitionAreas[i].destinationScene);
        }
      }
    }
    if (interactiveObjects != null) {
      for (int i = 0; i< interactiveObjects.size(); i++) {
        //click???
        if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, //check for collision and if pickable
          interactiveObjects.get(i).x, 
          interactiveObjects.get(i).y, 
          interactiveObjects.get(i).areaWidth, 
          interactiveObjects.get(i).areaHeight)
          &&(interactiveObjects.get(i).pickUp)) {
            
          inventory.add(interactiveObjects.get(i).item); //add to inventory
          interactiveObjects.remove(i); //remove the object from enviroment
        }
      }
    }

    //are there dialogue objects?
    if (dialogueObjects != null) {
      //every dialogue object
      for (int i = 0; i < dialogueObjects.length; i++) {
        //did the user click?
        if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, 
          dialogueObjects[i].x, 
          dialogueObjects[i].y, 
          dialogueObjects[i].areaWidth, 
          dialogueObjects[i].areaHeight)) {
          //play the dialogue
          dialogueObjects[i].dialogueToDisplay.Play();
        }
      }
    }
  }

  public void MouseHover() {
    //are there transition areas?
    if (transitionAreas !=null) {
      //every area
      for (int i = 0; i<transitionAreas.length; i++) {
        //mouse hovers over?
        if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, 
          transitionAreas[i].x, 
          transitionAreas[i].y, 
          transitionAreas[i].areaWidth, 
          transitionAreas[i].areaHeight)) {
          // if yes, change cursor and stop checking
          cursor(HAND);
          return;
        }
      }
    }

    //are there dialogue objects?
    if (dialogueObjects != null) {
      //for every dialogue object
      for (int i = 0; i < dialogueObjects.length; i++) {
        if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, 
          dialogueObjects[i].x, 
          dialogueObjects[i].y, 
          dialogueObjects[i].areaWidth, 
          dialogueObjects[i].areaHeight)) {
          //change the cursor and stop checking
          cursor(HAND);
          return;
        }
      }
    }
    
    //lock buttons
    if (buttons != null) {
      //for every dialogue object
      for (int i = 0; i < buttons.length; i++) {
        if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, 
          buttons[i].x, 
          buttons[i].y, 
          buttons[i].w, 
          buttons[i].h)) {
          //change the cursor and stop checking
          cursor(HAND);
          return;
        }
      }
    }

    //object checking added by Izabella
    //are there objects?
    if (interactiveObjects != null) {
      for (int i = 0; i<interactiveObjects.size(); i++) {
        //mouse hovers over?
        if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, 
          interactiveObjects.get(i).x, 
          interactiveObjects.get(i).y, 
          interactiveObjects.get(i).areaWidth, 
          interactiveObjects.get(i).areaHeight)) {
          // if yes, change cursor and stop checking
          cursor(HAND);
          return;
        }
      }
    } 

    //if not on transition area or interactive object && the player isn't dragging an item, the cursor is an arrow
    cursor(ARROW);
  }

  public void MouseReleased() {
    return;
  }
  public void numberClick(){
    
  }
}
