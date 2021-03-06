/*
    Copyright © 2020, Luna Nielsen
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/
module game;
import engine;
public import game.gamestate;
import bindbc.glfw;

private double previousTime_;
private double currentTime_;
private double deltaTime_;

/**
    Initializes the game
*/
void initGame() {

    // Set window title to something better
    GameWindow.title = "Kitsune Mahjong";
    GameWindow.setSwapInterval(SwapInterval.VSync);

    // Push the main menu to the stack
    GameStateManager.push(new IntroState());
}

/**
    The game loop
*/
void gameLoop() {
    resetTime();
    GameWindow.update();
    while(!GameWindow.isExitRequested) {

        currentTime_ = glfwGetTime();
        deltaTime_ = currentTime_-previousTime_;
        previousTime_ = currentTime_;
        
        // Clear color and depth buffers
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        // Reset OpenGL viewport
        GameWindow.resetViewport();

        // Update and render the game
        GameStateManager.update();
        GameStateManager.draw();

        // Update the mouse's state
        Mouse.update();

        // Swap buffers and update the window
        GameWindow.swapBuffers();
        GameWindow.update();
    }
    
    // Pop all game states so we can call destructors
    GameStateManager.popAll();
}

/**
    Gets delta time
*/
double deltaTime() {
    return deltaTime_;
}

/**
    Gets delta time
*/
double prevTime() {
    return previousTime_;
}

/**
    Gets delta time
*/
double currTime() {
    return currentTime_;
}

/**
    Resets the time scale
*/
void resetTime() {
    glfwSetTime(0);
    previousTime_ = 0;
    currentTime_ = 0;
}