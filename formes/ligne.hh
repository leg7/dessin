#pragma once

class Ligne {
public:
    Ligne(int x1, int y1, int x2, int y2):
        _x1(x1), _y1(y1), _x2(x2), _y2(y2)
    {}

private:
    int _x1;
    int _y1;
    int _x2;
    int _y2;
};

