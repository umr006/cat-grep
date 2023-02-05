#include "s21_cat.h"

int main(int argc, char **argv) {
  struct Options fl = {0};
  if (argc > 1) parser(argc, argv, &fl);
  reader(argc, argv, &fl);
}

void parser(int argc, char **argv, struct Options *fl) {
  int opt;
  int option_index = 0;
  const char *short_options = "benstvET?";

  const struct option long_options[] = {
      {"number-nonblank", no_argument, NULL, 'b'},
      {"squeeze-blank", no_argument, NULL, 's'},
      {"number", no_argument, NULL, 'n'},
      {0, 0, 0, 0}};

  while ((opt = getopt_long(argc, argv, short_options, long_options,
                            &option_index)) != -1) {
    switch (opt) {
      case 'b':
        fl->b++;
        break;
      case 'e':
        fl->e++;
        fl->v++;
        break;
      case 'n':
        fl->n++;
        break;
      case 's':
        fl->s++;
        break;
      case 't':
        fl->t++;
        fl->v++;
        break;
      case 'v':
        fl->v++;
        break;
      case 'E':
        fl->e++;
        break;
      case 'T':
        fl->t++;
        break;
      case '?':
        printf("usage: cat [-bens] [file ...]\n");
        exit(1);
    }
  }
}

void reader(int argc, char **argv, struct Options *fl) {
  int currentFile = optind;
  FILE *fp;
  while (currentFile < argc) {
    fp = fopen(argv[currentFile], "r");
    if (fp == NULL) {
      fprintf(stderr, "%s: %s: No such file or directory\n", argv[0],
              argv[currentFile]);
      exit(1);
    }
    int a = '\n', empty = 0;
    int kb, count = 1;
    while ((kb = fgetc(fp)) != EOF) {
      if (fl->b && kb != '\n' && a == '\n') {
        fl->n = 0;
        printf("%6d\t", count++);
      }
      if (fl->s && kb == '\n' && a == '\n') {
        empty++;
        if (empty > 1) continue;
      } else {
        empty = 0;
      }
      if (fl->n && a == '\n') {
        printf("%6d\t", count++);
      }
      if (fl->e && kb == '\n') printf("$");
      if (fl->t && kb == '\t') {
        kb = '^';
        putchar(kb);
        kb = 'I';
      }
      if (fl->v && kb != '\n') {
        if ((kb >= 0 && kb < 9) || (kb > 10 && kb <= 31)) {
          kb += 64;
          printf("^");
        } else if (kb == 127) {
          kb -= 64;
          printf("^");
        }
      }
      putchar(kb);
      a = kb;
    }
    fclose(fp);
    currentFile++;
  }
}

