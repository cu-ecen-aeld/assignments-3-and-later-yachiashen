#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <string.h>
int main(int argc, char **argv) {
    // Check for correct number of arguments
    if (argc != 3) {
        printf("Usage: %s <file> <string>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    // Open syslog with LOG_USER facility
    openlog("writer", LOG_PID, LOG_USER);

    // Extract file name and string to write from arguments
    char *file = argv[1];
    char *str = argv[2];

    // Log the writing action
    syslog(LOG_DEBUG, "Writing %s to %s", str, file);

    // Attempt to open file for writing
    FILE *fp = fopen(file, "w");
    if (fp == NULL) {
        syslog(LOG_ERR, "Error opening file %s", file);
        closelog();
        exit(EXIT_FAILURE);
    }

    // Write the string to the file
    if (fputs(str, fp) == EOF) {
        syslog(LOG_ERR, "Error writing to file %s", file);
        fclose(fp);
        closelog();
        exit(EXIT_FAILURE);
    }

    // Close the file
    if (fclose(fp) != 0) {
        syslog(LOG_ERR, "Error closing file %s", file);
        closelog();
        exit(EXIT_FAILURE);
    }

    // Close syslog
    closelog();

    return EXIT_SUCCESS;
}

