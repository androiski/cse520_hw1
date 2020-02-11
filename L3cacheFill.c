/*
Andrew Murza
CSE520 Spring 2020
Execution is meant to turn L3 cache into garbage data on i9-9820x 
By default it is 16.5MB
Pass in a single argument to change default value to the L3 of your machine
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {

    //initialize any variables
    unsigned char *data;
    int bytes;

    //if by default no arguments are passed (other than the ./a.out) we will use default L3 cache value of 16.5MB on the i9-9820X 
    if (argc == 1){
        bytes = (33*512*1024);//the same value as 16.5 * 1024^2 since we will only use int
    }
    else {
        //first argument passed after ./a.out should be the L3 size
        bytes = atoi(argv[1]);
    }
    
    //allocate that size
    data = (unsigned char *) malloc(bytes);

    //for-loop to fill in tthat size with random data
    srand(255);
    for(int i=0;i<bytes;i++){

        data[i] = (unsigned char) rand();

    }

return 0;

}