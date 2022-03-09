#!/bin/bash

ARGS=1

if [ $# -ne $ARGS ]  # check number args
then
  echo "Usage: `basename $0` filename"
  exit
fi

if [ ! -f $1 ]        # Check righ file arg
then
  echo "File \"$1\" does not exist."
  exit
fi

words=($(cat $1 | grep -E "[A-z]*"))

echo "Array items and indexes:" # Выводим записи массива с их индексами
for index in ${!words[*]}
do
    printf "%4d: %s\n" $index ${words[$index]}
done
