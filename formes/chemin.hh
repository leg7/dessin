#pragma once

#include <vector>

class Chemin {
    struct Point {
        int x;
        int y;
    };

public:
    Chemin(int x1, int y1):
        _points(1, Point{ x1, y1 })
    {}

    void ajoutePoint(int x, int y);

private:
    std::vector<Point> _points;
};


