#ifndef SRC_S21_CAT_H_
#define SRC_S21_CAT_H_

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

struct Options {
  int b;
  int s;
  int e;
  int t;
  int n;
  int v;
  int E;
  int T;
} fl;


void parser(int argc, char **argv, struct Options *fl);
void reader(int argc, char **argv, struct Options *fl);
#endif  // SRC_S21_CAT_H_