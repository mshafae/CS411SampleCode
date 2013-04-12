
#include <stdio.h>
#include <stdlib.h>

int main( void){
sqlite3* _databaseConnection;
    if (sqlite3_open("startrek.sl3", &_databaseConnection) != SQLITE_OK) {
      puts("Failed to open database.");
    }

