#pragma once
#pragma once

#include <vector>

#include "Forme.h"

class Chemin: public Forme {
    struct Point {
        int x;
        int y;
    };

public:
    Chemin(Proprietes prop, int x1, int y1)
        : Forme(prop), _points(1, Point{ x1, y1 })
    {}

    std::string to_svg() const override { return ""; }

    void ajoutePoint(int x, int y);

private:
    std::vector<Point> _points;
};


