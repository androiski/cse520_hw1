#!/bin/bash
OUTPUT=output$(cse520test +"%d_%m_%H_%M_%S").txt
echo "Assignment 1 - CSE520 Spring 2020 - Andrew Murza" >> $OUTPUT

COUNTER = (0 1 2 3)
TESTS = (1 2 3)
PERFS = (1 2 3)

CORES = (1 2 4 8)
THREADS = (2 4 8 16)

NHTSTRINGS = ("0" "0,1" "0,1,2,3" "0,1,2,3,4,5,6,7")
HTSTRINGS = ("0,14" "0,14,1,11" "0,14,1,11,2,12,3,13" "0,14,1,11,2,12,3,13,4,10,5,15,6,16,7,17")
TSTRINGS = ("time_duration,cycles" "L1-dcache-loads,L1-dcache-load-misses,r412E" "r4F2E,LLC-loads,LLC-load-misses")

for run in TESTS
do
echo -e "\nTRIAL NUMBER $run" >> $OUTPUT
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo -e "\n\nHYPERTHREADING DISABLED\n" >> $OUTPUT
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
    echo "TESTCASE 1 fluidanimate" >> $OUTPUT
    for count in COUNTER
    do
        cd ..
        for perfs in PERFS
        do
        cd tc1_fluidanimate
        perf stat -e ${TSTRINGS[perfs]} taskset -c $X ./fluidanimate ​${CORES[count]} 20 in_500K.fluid out.fluid -o $HOMEDIR/$OUTPUT --append
        ./a.out
        done
    done

    echo "TESTCASE 2 bodytrack " >> $OUTPUT
    for count in COUNTER
    do
        cd ..    
        for perfs in PERFS
        do
        cd tc2_bodytrack
        perf stat -e ${TSTRINGS[perfs]} taskset -c $X ./bodytrack sequenceB_261 4 20 4000 5 2 ​${CORES[count]}​ 4 -o $HOMEDIR/$OUTPUT --append
        ./a.out
        done
    done

    echo "TESTCASE 3 h264dec" >> $OUTPUT
    for count in COUNTER
    do
        cd ..
        for perfs in PERFS
        do
        cd tc3_h264dec
        perf stat -e ${TSTRINGS[perfs]} taskset -c $X ./h264dec -i ./park_joy_2160p.h264 -t ​${CORES[count]} -o $HOMEDIR/$OUTPUT --append
        ./a.out
        done
    done


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo -e "\n\nHYPERTHREADING ENABLED\n" >> $OUTPUT
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo "TESTCASE 1 fluidanimate" >> $OUTPUT
    for count in COUNTER
    do
        cd ..
        for perfs in PERFS
        do
        cd tc1_fluidanimate
        perf stat -e ${TSTRINGS[perfs]} taskset -c $X ./fluidanimate ​${THREADS[count]} 20 in_500K.fluid out.fluid -o $HOMEDIR/$OUTPUT --append
        done
    done

    echo "TESTCASE 2 bodytrack" >> $OUTPUT
    for count in COUNTER
    do
        cd ..
        for perfs in PERFS
        do
        cd tc2_bodytrack
        perf stat -e ${TSTRINGS[perfs]} taskset -c $X ./bodytrack sequenceB_261 4 20 4000 5 2 ​${THREADS[count]}​ 4 -o $HOMEDIR/$OUTPUT --append
        done
    done

    echo "TESTCASE 3 h264dec -HYPERTHREAD" >> $OUTPUT
    for count in COUNTER
    do
        cd ..
        for perfs in PERFS
        do
        cd tc3_h264dec
        perf stat -e ${TSTRINGS[perfs]} taskset -c $X ./h264dec -i ./park_joy_2160p.h264 -t ​${THREADS[count]} -o $HOMEDIR/$OUTPUT --append
        ./a.out
        done
    done
done

