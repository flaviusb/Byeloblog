#!/bin/bash
let errorCounter=0
./01.sh
if [ $? -ne 0 ]
then
  errorCounter=$(($errorCounter+1))
fi
./02.sh
if [ $? -ne 0 ]
then
  errorCounter=$(($errorCounter+1))
fi

tests="test"
if [ $errorCounter -ne 1 ]
then
  tests="tests"
fi
FGRED=`printf "\033[31m"`
FGGREEN=`printf "\033[32m"`
NORMAL=`printf "\033[m"`
if [ $errorCounter -ne 0 ]
then
  echo "${FGRED}$errorCounter $tests failed.${NORMAL}"
else
  echo "${FGGREEN}$errorCounter $tests failed.${NORMAL}"
fi
exit $errorCounter
