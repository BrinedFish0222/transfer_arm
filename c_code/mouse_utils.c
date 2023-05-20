#include <windows.h>
#include "mouse_utils.h"

int main() {
    // 获取屏幕宽度和高度
    int screenWidth = GetSystemMetrics(SM_CXSCREEN);
    int screenHeight = GetSystemMetrics(SM_CYSCREEN);

    // 设置鼠标移动到屏幕中央
    int targetX = screenWidth / 2;
    int targetY = screenHeight / 2;
    
    mouseMove(targetX, targetY);

    return 0;
}

void mouseMove(int x, int y) {
    SetCursorPos(x, y);
}