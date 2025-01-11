#include <SDL2/SDL.h> // Include the SDL library header
#include <iostream>   // Include the iostream library for console output

int main(int argc, char* argv[]) {
    // Initialize SDL's video subsystem
    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        std::cout << "Subsystem error: " << SDL_GetError() << std::endl;
        return 1; // Exit the program if there's an error
    }

    // Create an SDL window with the title "VM Display"
    SDL_Window* window = SDL_CreateWindow(
        "Operating System Display",    // Window title
        100, 100,        // Window position (x, y)
        800, 600,        // Window size (width, height)
        SDL_WINDOW_SHOWN // Window flags (make the window visible)
    );
    if (window == nullptr) {
        std::cout << "Failure to create a window: " << SDL_GetError() << std::endl;
        SDL_Quit(); // Clean up and exit if there's an error
        return 1;
    }

    // Create a renderer for the window
    SDL_Renderer* renderer = SDL_CreateRenderer(
        window, -1, // Use the first available renderer driver
        SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC // Renderer flags
    );
    if (renderer == nullptr) {
        std::cout << "SDL_CreateRenderer Error: " << SDL_GetError() << std::endl;
        SDL_DestroyWindow(window); // Destroy the window if there's an error
        SDL_Quit(); // Clean up and exit if there's an error
        return 1;
    }

    // Set the renderer's draw color to black (RGB: 0, 0, 0)
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);

    // Clear the screen with the draw color
    SDL_RenderClear(renderer);

    // Present the renderer (display the changes on the screen)
    SDL_RenderPresent(renderer);

    // Wait for 3000 milliseconds (3 seconds) before closing the window
    SDL_Delay(3000);

    // Clean up and destroy the renderer and window
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);

    // Quit SDL
    SDL_Quit();

    return 0; // Exit the program successfully
}
