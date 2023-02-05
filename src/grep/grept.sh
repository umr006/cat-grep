#!/bin/bash

COUNTER_SUCCESS=0
COUNTER_FAIL=0
DIFF_RES=""
TEST_FILE1="test.txt"
TEST_FILE2="test1.txt"
TEST_FILE3="test2.txt"
PAT1="v"
PAT2="nec"
PAT3="et"
PAT3='123'
PAT4='asd'
PATFILE1='pattern1.txt'
PATFILE2='pattern2.txt'
PATFILE3='pattern3.txt'
PATFILE4='pattern4.txt'
echo "" > log.txt

#-------------------------------SIMPLE FLAGS--------------------------------------#

echo "SIMPLE FLAGS"

TEST1="$PAT1 $TEST_FILE1"
grep $TEST1 > a
./s21_grep $TEST1 > b
DIFF_RES="$(diff -s a b)"
if [ "$DIFF_RES" == "Files a and b are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
  else
    echo "$TEST1" >> log.txt
    (( COUNTER_FAIL++ ))
fi
rm a b

TEST1="$PAT3 $TEST_FILE1 $TEST_FILE2"
grep $TEST1 > a
./s21_grep $TEST1 > b
DIFF_RES="$(diff -s a b)"
if [ "$DIFF_RES" == "Files a and b are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
  else
    echo "$TEST1" >> log.txt
    (( COUNTER_FAIL++ ))
fi
rm a b

for file in $TEST_FILE1 $TEST_FILE2
do
  for pat in $PAT1 $PAT2 $PAT3 $PAT4
  do
    for var in -i -v -c -l -n -h -s -o
    do
      TEST1="$var $pat $file"
      grep $TEST1 > a
      ./s21_grep $TEST1 > b
      DIFF_RES="$(diff -s a b)"
      if [ "$DIFF_RES" == "Files a and b are identical" ]
        then
          (( COUNTER_SUCCESS++ ))
        else
          echo "$TEST1" >> log.txt
          (( COUNTER_FAIL++ ))
      fi
      rm a b
    done
  done
done
echo "PROCESSING"
for pat in $PAT1 $PAT2 $PAT3 $PAT4
  do
    for var in -i -v -c -l -n -h -s -o
    do
      TEST1="$var $pat $TEST_FILE1 $TEST_FILE2"
      grep $TEST1 > a
      ./s21_grep $TEST1 > b
      DIFF_RES="$(diff -s a b)"
      if [ "$DIFF_RES" == "Files a and b are identical" ]
        then
          (( COUNTER_SUCCESS++ ))
        else
          echo "$TEST1" >> log.txt
          (( COUNTER_FAIL++ ))
      fi
      rm a b
  done
done
echo "PROCESSING"
for file in $TEST_FILE1 $TEST_FILE2
do
  for pat in $PAT1 $PAT2 $PAT3 $PAT4
  do
    for var1 in -i -v -c -l -n -h -s -o
    do
      for var2 in -i -v -c -l -n -h -s -o
      do
        if [ var1 != var2 ]
          then

            TEST1="$var1 $var2 $pat $file"
            grep $TEST1 > a
            ./s21_grep $TEST1 > b
            DIFF_RES="$(diff -s a b)"
            if [ "$DIFF_RES" == "Files a and b are identical" ]
              then
                (( COUNTER_SUCCESS++ ))
              else
                echo "$TEST1" >> log.txt
                (( COUNTER_FAIL++ ))
              fi
            rm a b
          fi
      done
    done
    echo "PROCESSING"
  done
done
echo "PROCESSING"

for pat in $PAT1 $PAT2 $PAT3 $PAT4
do
  for var1 in -i -v -c -l -n -h -s -o
  do
    for var2 in -i -v -c -l -n -h -s -o
    do
      if [ var1 != var2 ]
        then
          TEST1="$var1 $var2 $pat $TEST_FILE1 $TEST_FILE2"
          grep $TEST1 > a
          ./s21_grep $TEST1 > b
          DIFF_RES="$(diff -s a b)"
          if [ "$DIFF_RES" == "Files a and b are identical" ]
            then
              (( COUNTER_SUCCESS++ ))
            else
              echo "$TEST1" >> log.txt
              (( COUNTER_FAIL++ ))
          fi
          rm a b
        fi
    done
  done
done
echo "PROCESSING"
for file in $TEST_FILE1 $TEST_FILE2
do
  for pat in $PAT1 $PAT2 $PAT3 $PAT4
  do
    for var1 in -i -v -c -l -n -h -s -o
    do
      for var2 in -i -v -c -l -n -h -s -o
      do
        for var3 in -i -v -c -l -n -h -s -o
        do
          if [ $var1 != $var2 ] && [ $var2 != $var3 ] && [ $var1 != $var3 ]
            then
              TEST1="$var1 $var2 $pat $file"
              grep $TEST1 > a
              ./s21_grep $TEST1 > b
              DIFF_RES="$(diff -s a b)"
              if [ "$DIFF_RES" == "Files a and b are identical" ]
                then
                  (( COUNTER_SUCCESS++ ))
                else
                  echo "$TEST1" >> log.txt
                  (( COUNTER_FAIL++ ))
                fi
              rm a b
            fi
        done
      done
    done
  done
done

echo "PROCESSING"
for pat in $PAT1 $PAT2 $PAT3 $PAT4
do
  for var1 in -i -v -c -l -n -h -s -o
  do
    for var2 in -i -v -c -l -n -h -s -o
    do
      for var3 in -i -v -c -l -n -h -s -o
      do
        if [ $var1 != $var2 ] && [ $var2 != $var3 ] && [ $var1 != $var3 ]
          then
            TEST1="$var1 $var2 $var3 $pat $TEST_FILE1 $TEST_FILE2"
            grep $TEST1 > a
            ./s21_grep $TEST1 > b
            DIFF_RES="$(diff -s a b)"
            if [ "$DIFF_RES" == "Files a and b are identical" ]
              then
                (( COUNTER_SUCCESS++ ))
              else
                echo "$TEST1" >> log.txt
                (( COUNTER_FAIL++ ))
              fi
            rm a b
          fi
      done
    done
  done
done

#-------------------------------E FLAG--------------------------------------#

echo "E FLAGS"

TEST1=" -e $PAT1 $TEST_FILE1"
grep $TEST1 > a
./s21_grep $TEST1 > b
DIFF_RES="$(diff -s a b)"
if [ "$DIFF_RES" == "Files a and b are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
  else
    echo "$TEST1" >> log.txt
    (( COUNTER_FAIL++ ))
fi
rm a b

TEST1=" -e $PAT2 $TEST_FILE1 $TEST_FILE2"
grep $TEST1 > a
./s21_grep $TEST1 > b
DIFF_RES="$(diff -s a b)"
if [ "$DIFF_RES" == "Files a and b are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
  else
    echo "$TEST1" >> log.txt
    (( COUNTER_FAIL++ ))
fi
rm a b

for file in $TEST_FILE1 $TEST_FILE2
do
  for pat in $PAT1 $PAT2 $PAT3 $PAT4
  do
    for var in -i -v -c -l -n -h -s -o
    do
      if [ var1 != var2 ]
        then
          TEST1="$var -e $pat $file"
          grep $TEST1 > a
          ./s21_grep $TEST1 > b
          DIFF_RES="$(diff -s a b)"
          if [ "$DIFF_RES" == "Files a and b are identical" ]
            then
              (( COUNTER_SUCCESS++ ))
            else
              echo "$TEST1" >> log.txt
              (( COUNTER_FAIL++ ))
          fi
          rm a b
        fi
    done
  done
done
echo "PROCESSING"
for pat in $PAT1 $PAT2 $PAT3 $PAT4
do
  for var in -i -v -c -l -n -h -s -o
  do
    if [ var1 != var2 ]
      then
        TEST1="$var -e $pat $TEST_FILE1 $TEST_FILE2"
        grep $TEST1 > a
        ./s21_grep $TEST1 > b
        DIFF_RES="$(diff -s a b)"
        if [ "$DIFF_RES" == "Files a and b are identical" ]
          then
            (( COUNTER_SUCCESS++ ))
          else
            echo "$TEST1" >> log.txt
            (( COUNTER_FAIL++ ))
        fi
        rm a b
      fi
  done
done
echo "PROCESSING"
for file in $TEST_FILE1 $TEST_FILE2
do
  for pat1 in $PAT1 $PAT2 $PAT3 $PAT4
  do
    for pat2 in $PAT1 $PAT2 $PAT3 $PAT4
    do
      for var in -i -v -c -l -n -h -s
      do
        if [ pat1 != pat2 ]
          then
            TEST1="$var -e $pat1 -e $pat2 $file"
            grep $TEST1 > a
            ./s21_grep $TEST1 > b
            DIFF_RES="$(diff -s a b)"
            if [ "$DIFF_RES" == "Files a and b are identical" ]
              then
                (( COUNTER_SUCCESS++ ))
              else
                echo "$TEST1" >> log.txt
                (( COUNTER_FAIL++ ))
            fi
            rm a b
          fi
      done
    done
  done
done
echo "PROCESSING"
for pat1 in $PAT1 $PAT2 $PAT3 $PAT4
do
  for pat2 in $PAT1 $PAT2 $PAT3 $PAT4
  do
    for var in -i -v -c -l -n -h -s
    do
      if [ pat1 != pat2 ]
        then
          TEST1="$var -e $pat1 -e $pat2 $TEST_FILE1 $TEST_FILE2"
          grep $TEST1 > a
          ./s21_grep $TEST1 > b
          DIFF_RES="$(diff -s a b)"
          if [ "$DIFF_RES" == "Files a and b are identical" ]
            then
              (( COUNTER_SUCCESS++ ))
            else
              echo "$TEST1" >> log.txt
              (( COUNTER_FAIL++ ))
          fi
          rm a b
        fi
    done
  done
done

#-------------------------------F FLAG--------------------------------------#

echo "F FLAGS"

for file in $TEST_FILE1 $TEST_FILE2
do
  for patfile in $PATFILE1 $PATFILE2 $PATFILE3 $PATFILE4
  do
    TEST1=" -f $patfile $file"
    grep $TEST1 > a
    ./s21_grep $TEST1 > b
    DIFF_RES="$(diff -s a b)"
    if [ "$DIFF_RES" == "Files a and b are identical" ]
      then
        (( COUNTER_SUCCESS++ ))
      else
        echo "$TEST1" >> log.txt
        (( COUNTER_FAIL++ ))
    fi
    rm a b
  done
done

for patfile in $PATFILE1 $PATFILE2 $PATFILE3 $PATFILE4
do
  TEST1=" -f $patfile $TEST_FILE1 $TEST_FILE2"
  grep $TEST1 > a
  ./s21_grep $TEST1 > b
  DIFF_RES="$(diff -s a b)"
  if [ "$DIFF_RES" == "Files a and b are identical" ]
    then
      (( COUNTER_SUCCESS++ ))
    else
      echo "$TEST1" >> log.txt
      (( COUNTER_FAIL++ ))
  fi
  rm a b
done

echo "PROCESSING"

for file in $TEST_FILE1 $TEST_FILE2
do
  for patfile in $PATFILE1 $PATFILE2 $PATFILE3 $PATFILE4
  do
    for var in -i -v -c -l -n -h -s
    do
      if [ var1 != var2 ]
        then
          TEST1="$var -f $patfile $file"
          grep $TEST1 > a
          ./s21_grep $TEST1 > b
          DIFF_RES="$(diff -s a b)"
          if [ "$DIFF_RES" == "Files a and b are identical" ]
            then
              (( COUNTER_SUCCESS++ ))
            else
              echo "$TEST1" >> log.txt
              (( COUNTER_FAIL++ ))
          fi
          rm a b
        fi
    done
  done
done

echo "PROCESSING"

for patfile in $PATFILE1 $PATFILE2 $PATFILE3 $PATFILE4
do
  for var in -i -v -c -l -n -h -s
  do
    if [ var1 != var2 ]
      then
        TEST1="$var -f $patfile $TEST_FILE1 $TEST_FILE2"
        grep $TEST1 > a
        ./s21_grep $TEST1 > b
        DIFF_RES="$(diff -s a b)"
        if [ "$DIFF_RES" == "Files a and b are identical" ]
          then
            (( COUNTER_SUCCESS++ ))
          else
            echo "$TEST1" >> log.txt
            (( COUNTER_FAIL++ ))
        fi
        rm a b
      fi
  done
done

echo "PROCESSING"

for file in $TEST_FILE1 $TEST_FILE2
do
  for patfile1 in $PATFILE1 $PATFILE2 $PATFILE3 $PATFILE4
  do
    for patfile2 in $PATFILE1 $PATFILE2 $PATFILE3 $PATFILE4
    do
      for var in -i -v -c -l -n -h -s
      do
        if [ pat1 != pat2 ]
          then
            TEST1="$var -f $patfile1 -f $patfile2 $file"
            grep $TEST1 > a
            ./s21_grep $TEST1 > b
            DIFF_RES="$(diff -s a b)"
            if [ "$DIFF_RES" == "Files a and b are identical" ]
              then
                (( COUNTER_SUCCESS++ ))
              else
                echo "$TEST1" >> log.txt
                (( COUNTER_FAIL++ ))
            fi
            rm a b
          fi
      done
    done
  done
done

echo "PROCESSING"

for patfile1 in $PATFILE1 $PATFILE2 $PATFILE3 $PATFILE4
do
  for patfile2 in $PATFILE1 $PATFILE2 $PATFILE3 $PATFILE4
  do
    for var in -i -v -c -l -n -h -s
    do
      if [ pat1 != pat2 ]
        then
          TEST1="$var -f $patfile1 -f $patfile2 $TEST_FILE1 $TEST_FILE2"
          grep $TEST1 > a
          ./s21_grep $TEST1 > b
          DIFF_RES="$(diff -s a b)"
          if [ "$DIFF_RES" == "Files a and b are identical" ]
            then
              (( COUNTER_SUCCESS++ ))
            else
              echo "$TEST1" >> log.txt
              (( COUNTER_FAIL++ ))
          fi
          rm a b
        fi
    done
  done
done

echo "----- FINISHED -----"
echo "SUCCESS: $COUNTER_SUCCESS"
echo "FAIL: $COUNTER_FAIL"
