#include "s21_grep.h"

int main(int argc, char** argv) {
  struct flags options = {0};
  cnt_file(argc, argv, &options);
  int i = options.args;
  if (!(parser(argc, argv, &options))) {
    while (i < argc) {
      if (options.f) {
        if (argv[i][0] != '-' && check_file(argv[i])) print(argv[i], &options);
      }
      if (argv[i][0] != '-' && check_file(argv[i]) && !options.f) {
        print(argv[i], &options);
      }
      i++;
    }
  }
  return 0;
}

int check_file(char* file) {
  FILE* file_ptr;
  file_ptr = fopen(file, "r");
  if (file_ptr == NULL) {
    return 0;
  }
  fclose(file_ptr);
  return 1;
}

int parser(int argc, char* argv[], struct flags* options) {
  int opt = 0;
  const char* s_options = "e:ivclnhsf:o";
  while ((opt = getopt(argc, argv, s_options)) != -1) {
    switch (opt) {
      case 'e':
        options->e = 1;
        strcpy(options->pattern[options->buffernator++], optarg);
        break;
      case 'i':
        options->i = 1;
        break;
      case 'v':
        options->v = 1;
        break;
      case 'c':
        options->c = 1;
        break;
      case 'l':
        options->l = 1;
        break;
      case 'n':
        options->n = 1;
        break;
      case 'h':
        options->h = 1;
        break;
      case 's':
        options->s = 1;
        break;
      case 'f':
        options->f = 1;
        f_flag_open_file(options);
        break;
      case 'o':
        options->o = 1;
        break;
      case '?':
        fprintf(stderr,
                "usage: grep [-abcDEFGHhIiJLlmnOoqRSsUVvwxZ] [-A num] [-B num] "
                "[-C[num]]");
        return 1;
      default:
        break;
    }
  }
  for (int i = 1; i < argc; i++) {
    if (*argv[i] != '-' && !options->f && !options->e) {
      strcpy(options->pattern[options->buffernator++], argv[i]);
      break;
    }
  }
  return 0;
}

void cnt_file(int argc, char* argv[], struct flags* options) {
  int sch = 0, i = 0;
  if (argv[1][0] != '-')
    options->args = i = 2;
  else
    options->args = i = 3;
  while (i < argc) {
    sch++;
    i++;
  }
  options->cnt_file = sch;
}

int f_flag_open_file(struct flags* options) {
  FILE* file_tmp;
  size_t len;
  char* line = NULL;
  file_tmp = fopen(optarg, "r");
  if (file_tmp != NULL) {
    while ((getline(&line, &len, file_tmp)) != EOF) {
      if (line[0] == '\n') options->blank_line = 1;
      if (line[strlen(line) - 1] == '\n') line[strlen(line) - 1] = '\0';
      strcpy(options->pattern[options->buffernator++], line);
    }
    if (line) free(line);
    fclose(file_tmp);
  } else {
    return 0;
  }
  return 1;
}

void no_flags(char* file) {
  FILE* file_tmp;
  file_tmp = fopen(file, "r");
  if (file_tmp != NULL) {
    int c;
    while ((c = fgetc(file_tmp)) != EOF) printf("%c", c);
    fclose(file_tmp);
  }
}

int print(char* file, struct flags* options) {
  if (options->blank_line) {
    no_flags(file);
    return 1;
  }
  if (options->l) {
    options->n = 0;
    options->o = 0;
  }
  if (options->c) {
    options->n = 0;
    options->o = 0;
  }
  if (options->v) options->o = 0;
  FILE* file_ptr;
  file_ptr = fopen(file, "r");
  size_t len = 0;
  regex_t regex;
  regmatch_t mach[1];
  char* line = NULL;
  if (file_ptr != NULL) {
    int count_n = 0, count_c = 0;
    while ((getline(&line, &len, file_ptr)) != -1) {
      count_n++;
      int done = 0;
      for (int k = 0; k < options->buffernator; k++) {
        int err;
        int success =
            regcomp(&regex, options->pattern[k], (options->i) ? REG_ICASE : 0);
        options->success = success;
        if ((err = regexec(&regex, line, 1, mach, 0)) == options->v) {
          if (line[strlen(line) - 1] == '\n') line[strlen(line) - 1] = '\0';
          count_c++;
          done = 1;
        }
        regfree(&regex);
      }
      if ((!options->c && !options->l) && done) {
        if (options->cnt_file > 1 && !options->h) printf("%s:", file);
        if (options->n) printf("%d:", count_n);
        if (options->o) {
          for (int l = 0; l < options->buffernator; l++) {
            regcomp(&regex, options->pattern[l], (options->i) ? REG_ICASE : 0);
            for (int x = (int)mach[0].rm_so; x < (int)mach[0].rm_eo; x++) {
              printf("%c", line[x]);
            }
            printf("\n");
            regfree(&regex);
          }
        } else {
          printf("%s\n", line);
        }
      }
    }
    if (options->l && count_c) printf("%s\n", file);
    if (options->c && options->cnt_file > 1)
      printf("%s:%d\n", file, count_c);
    else if (options->c && options->cnt_file < 2)
      printf("%d\n", count_c);
    fclose(file_ptr);
    free(line);
  } else {
    if (!options->s) {
      fprintf(stderr, "s21_grep: %s: No such file or directory\n", file);
    }
  }
  return 0;
}