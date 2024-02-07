#pragma once
#pragma once

#include "Forme.h"

class Ligne: public Forme {
public:
    Ligne(Proprietes prop, int x1, int y1, int x2, int y2)
        : Forme(prop), _x1(x1), _y1(y1), _x2(x2), _y2(y2)
    {}

    std::string to_svg() const override { return ""; }

private:
    int _x1;
    int _y1;
    int _x2;
    int _y2;
};

