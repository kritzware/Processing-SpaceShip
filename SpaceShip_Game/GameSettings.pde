class GameSettings {

  //  UI objects
  UI health, oxygen, planetNameUI, ftl_travel, modal1, shipDisplayPanel;
  UI travelMenu;
  UI travelInfo;
  UI eventPanel;
  UI planetHoverInfo;
  boolean buttonHover = false;
  
  //  Inventory
  Inventory inventory;
  
  //  Ship configurations
  int shipHealth = 300;
  int shipHealthCurrent = 300;

  int shipOxygen = 100;
  int shipOxygenCurrent = 100;

  //  UI Colors
  color shipHealthColor = color(0, 255, 0);
  color shipOxygenColor = color(114, 188, 212);
  color planetNameUIColor = color(255);
  color goodHP = color(0, 255, 0);
  color lowHP = color(255, 71, 25);
  color verylowHP = color(255, 0, 0);
  color gain = color(0, 255, 0);
  color loss = color(255, 0, 0);
  
  //  UI Fonts
  int event_log_size = 14;
  int event_message_size = 14;
  int event_choice_size = 12;

  //  Create a planet object
  Planet planet;
  
  //  Crew
  // Crew crew1, crew2, crew3;
  // Crew[] crew;
  ArrayList<Crew> crew = new ArrayList<Crew>();
  
  //  Travel window object
  Travel travel;
  
  //  Create random event object;
  Event newEvent;
  
  GameOver mainGameOver;
  
  // Game states
  boolean travelPanelOpen = false;
  boolean inventoryOpen = false;
  boolean eventOpen = false;
  boolean eventPanelClosed = true;
  boolean planetHoverInfoOpen = false;
  boolean eventResponsesOpen = false;
  boolean create_planet = true;
  
  boolean game_over = false;

  // Game default config
  float resourceTimer;
  boolean audioMuted = false;
  
  // Load Images
  PImage defaultPointer, game_over_background;
  
  // test vars
  int planet_counter;

  GameSettings() {
        
    createPlanet();
    
    // Create the crew objects
    //crew1 = new Crew("Walker", "Engineer", 400, 10, 400, 45);
    //crew2 = new Crew("Andez", "Physicist", 460, 10, 460, 45);
    //crew3 = new Crew("Cooper", "Pilot", 520, 10, 520, 45);
    crew.add(new Crew("Walker", "Engineer", 400, 10, 400, 45));
    crew.add(new Crew("Andez", "Physicist", 460, 10, 460, 45));
    crew.add(new Crew("Cooper", "Pilot", 520, 10, 520, 45));
    
    // Load cursor image
    defaultPointer = loadImage("pointer_shadow.png");
    
    // Create various UI elements
    shipDisplayPanel = new UI(0, 0, "Section", color(255));
    health = new UI(20, 20, "Health (" + shipHealthCurrent + " / " + shipHealth + ")", shipHealthColor);
    oxygen = new UI(20, 55, "Oxygen (" + shipOxygenCurrent + " / " + shipOxygen + ")", shipOxygenColor);
    
    //  ftl_travel = new UI(0, 0, "HYPERSPACE", color(255));
    
    travelMenu = new UI(0, 0, "travelMenu", color(255));
    travelInfo = new UI(0, 0, "travelInfo", color(255));
    eventPanel = new UI(0, 0, "eventPanel", color(255));
    planetHoverInfo = new UI(1200, height/2 + 200, "planetHoverinfo", color(255));
    
    // Create various objects
    inventory = new Inventory();
    travel = new Travel();
  }
  
  void createPlanet() {
    planetTransition();
    planet = new Planet(color(random(255), random(255), random(255)), (int)random(5, 25), random(100, 300), PI / 50, random(-0.2, 0.2), planet_counter);
    planetNameUI = new UI(20, 90, "Planet: " + planet.planetNameRandom, planetNameUIColor);
    planet_counter++;
  }
  
  void startNewEvent() {
    newEvent = new Event();
    eventOpen = true;
  }

  void createLevel() {
    planet.planetRender();
    drawUI();
    drawCursor(1);
  }
  
  void gameOver() {
    if(game_over == false) {
      println("[INFO] Game over state started");
      mainGameOver = new GameOver();
      game_over_music.loop();
      game_over = true;
    }
  }
  
  void drawUI() {
    health.draw();
    health.bar(20, 25, shipHealthCurrent, 10, shipHealthColor, 300);
    oxygen.draw();
    oxygen.bar(20, 60, shipOxygenCurrent, 10, shipOxygenColor, 100);
    planetNameUI.draw();
    
    //  ftl_travel.button(1300, 40);
    
    if((mainShip.shipEngineOpen || mainShip.shipMainOpen || mainShip.shipArrayTopOpen || mainShip.shipArrayBottomOpen || mainShip.shipPilotOpen) && travelPanelOpen == false) {
     shipDisplayPanel.shipSectionDisplay();
    }
    drawTravelMenu();
    drawInventory();
    drawEvent();
    drawPlanetHoverInfo();
    drawCrew();
  }
  
  void drawCrew() {
    //crew1.draw_crew();
    //crew2.draw_crew();
    //crew3.draw_crew();
    for(Crew members : crew) {
      members.draw_crew();
    }
  }
  
  void drawCursor(float cursor) {
    if(cursor == 1) {
      cursor(defaultPointer, 0, 0);
    }
  }
  
  void gamePause() {
    planet.planetRevolution = 0;
  }
  
  void drawTravelMenu() {
    travel.drawTravelButton();
    if(travelPanelOpen) {
      //  travel.closeTravelButton();
      shipStateChange();
      travel.draw();
      //  travelMenu.travelPanelDisplay();
    }
  }
  
  void drawInventory() {
    if(inventoryOpen) {
      shipStateChange();
      inventory.loadDefault();
    }
  }
  
  void drawEvent() {
    if(eventOpen) {
      shipStateChange();
      newEvent.displayEventMessage();
      eventPanelClosed = false;
    }
  }
  
  void drawPlanetHoverInfo() {
    if(planetHoverInfoOpen && travelPanelOpen == false && eventOpen == false) {
     // if(planetHoverInfoOpen && (travelPanelOpen == false || inventoryOpen == false || eventOpen == false)) {
      planetHoverInfo.planetHoverInfo();
    }
  }
  
  void shipStateChange() {
    mainShip.shipEngineOpen = false;
    mainShip.shipMainOpen = false;
    mainShip.shipArrayBottomOpen = false;
    mainShip.shipArrayTopOpen = false;
    mainShip.shipPilotOpen = false;
  }
  
  void planetTransition() {
    fill(255);
    rect(0, 0, width, height);
  }
}