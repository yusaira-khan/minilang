#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* add_s(char *s1, char *s2){
    size_t len1 = strlen(s1);
    size_t len2 = strlen(s2);
    char *result = malloc(len1+len2+1);//+1 for the zero-terminator
    memcpy(result, s1, len1);
    memcpy(result+len1, s2, len2+1);//+1 to copy the null-terminator
    return result;
}

char* neg_s(char *s1){
    size_t len1 = strlen(s1);
    int c, i, j;
    char *result = malloc(len1+1);
    for (i = 0, j = len1-1; i < len1; i++, j--){
       result[j] = s1[i];
    }
    result[len1]='\0';
    return result;
}

int main(){
  char* x;
  scanf( "%s",x);
  printf( "%s\n",x );
  return 0;
}
