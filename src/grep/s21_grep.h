#ifndef SRC_S21_GREP_H_
#define SRC_S21_GREP_H_

#include <getopt.h>
#include <limits.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct flags {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
  int args;
  int blank_line;
  int success;
  int buffernator;
  int cnt_file;
  char pattern[1024][1024];
};

void cnt_file(int argc, char* argv[], struct flags* options);
int parser(int argc, char* argv[], struct flags* options);
int f_flag_open_file(struct flags* options);
void no_flags(char* file);
int print(char* file, struct flags* options);
int check_file(char* file);

#endif  // SRC_S21_GREP_H_
