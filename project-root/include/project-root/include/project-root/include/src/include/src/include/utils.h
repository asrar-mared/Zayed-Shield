#include <stdio.h>
#include "utils.h"

void init_utils() {
    printf("🛠️ أدوات النظام جاهزة.\n");
}

void log_message(const char *msg) {
    printf("[LOG] %s\n", msg);
}
