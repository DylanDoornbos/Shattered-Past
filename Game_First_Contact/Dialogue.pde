class Dialogue {

  //Lines of dialogue
  String[] dialogueLines;

  //Which line of dialogue is currently shown
  int currentDialogueLine = 0;

  //Constructor
  public Dialogue(String[] newDialogue) {
    dialogueLines = newDialogue;
  }

  public void Draw() {
    //Draw the dialogue box
    image(dialogueBoxImage, 0, 0);
    //rect(0, height - 150, width, 150);
    fill(255, 255, 255);
    textAlign(CENTER, CENTER);
    textSize(20);

    String characterName = "";
    String dialogueContent = dialogueLines[currentDialogueLine];
    
    if (dialogueContent.substring(0, 3).equals("P: ")) {
      dialogueContent = dialogueContent.substring(3);
      characterName = "Veronica";
      image(nameBoxImage, 0, 0);
    } else if (dialogueContent.substring(0, 3).equals("T: ")) {
      dialogueContent = dialogueContent.substring(3);
      characterName = "Therapist";
      image(nameBoxImage, 0, 0);
    }
    
    text(characterName, 215, height - 187, 190, 30);
    text(dialogueContent, 200, height - 137, width - 400, 137);
  }

  public void MouseClicked() {
    //If the mouse clicks on the "next dialogue" button
    if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, 0, height - 150, width, 150)) {

      //If this was the last line of dialogue...
      if (currentDialogueLine == dialogueLines.length - 1) {

        //Stop showing dialogue
        Game_First_Contact.dialogueActive = false;

        //Reset the dialogueLine
        currentDialogueLine = 0;

        //Unhide the inventory (If the scene allows it)
        Game_First_Contact.displayInventory = Game_First_Contact.activeScene.allowInventory;
      } //Else go to the next line
      else {
        currentDialogueLine++;
      }
    }
  }

  public void MouseHover() {
    //Check if the mouse is on the text box
    if (Game_First_Contact.CheckPointOnBoxCollision(mouseX, mouseY, 0, height - 150, width, 150)) {
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
  }

  public void Play() {
    Game_First_Contact.activeDialogue = this;
    Game_First_Contact.dialogueActive = true;
    Game_First_Contact.displayInventory = false;
  }
}
