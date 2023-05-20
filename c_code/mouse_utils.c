#include <windows.h>
#include <stdio.h>
#include "mouse_utils.h"

int main()
{
    mouseMove(100, 100);
    mouseClick(0);

    return 0;
}

void mouseClick(int type)
{
    if (type == 1)
    {
        // 中键点击
        mouse_event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0);
        mouse_event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0);
        return;
    }
    else if (type == 2)
    {
        // 右键点击
        mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
        mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
        return;
    }

    // 左键点击
    mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
    mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
}

void mouseMove(int x, int y)
{
    SetCursorPos(x, y);
}