#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function to create a disk image
void create_disk_image(const char *filename, const char *iso_filename, size_t disk_size) {
    FILE *file = fopen(filename, "wb");
    if (!file) {
        perror("Failed to create disk image");
        exit(EXIT_FAILURE);
    }

    // Allocate memory for the disk image
    void *disk_image = malloc(disk_size);
    if (!disk_image) {
        perror("Failed to allocate memory for disk image");
        fclose(file);
        exit(EXIT_FAILURE);
    }

    // Initialize the disk image with zeros
    memset(disk_image, 0, disk_size);

    // Here, you can add code to copy the ISO content into the disk image if needed

    // Write the disk image to the file
    size_t bytes_written = fwrite(disk_image, 1, disk_size, file);
    if (bytes_written != disk_size) {
        perror("Failed to write disk image to file");
        free(disk_image);
        fclose(file);
        exit(EXIT_FAILURE);
    }

    // Clean up
    free(disk_image);
    fclose(file);

    printf("Disk image '%s' created successfully using ISO '%s' with size %lu bytes!\n", filename, iso_filename, disk_size);
}

int main() {
    char filename[256];
    char iso_filename[256];
    int choice;
    size_t disk_size;

    // Prompt the user for the disk image filename
    printf("Enter the name of the disk image file (e.g., my_disk.img): ");
    scanf("%255s", filename);

    // Prompt the user to choose the operating system
    printf("Choose the operating system:\n");
    printf("1. Linux\n");
    printf("2. Windows\n");
    printf("Enter your choice (1 or 2): ");
    scanf("%d", &choice);

    // Prompt the user for the ISO image filename based on the choice
    if (choice == 1) {
        printf("Enter the name of the Linux ISO file (e.g., linux.iso): ");
    } else if (choice == 2) {
        printf("Enter the name of the Windows ISO file (e.g., windows.iso): ");
    } else {
        printf("Invalid choice!\n");
        return EXIT_FAILURE;
    }
    scanf("%255s", iso_filename);

    // Prompt the user for the disk image size in MB
    printf("Enter the size of the disk image in MB (e.g., 100): ");
    scanf("%lu", &disk_size);

    // Convert size from MB to bytes
    disk_size *= 1024 * 1024;

    // Create the disk image using the chosen ISO file and user-defined size
    create_disk_image(filename, iso_filename, disk_size);

    return 0;
}
