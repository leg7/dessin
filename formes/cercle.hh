#pragma once

#include "forme.hh"

class Cercle: public Forme {
public:
    Cercle(Proprietes prop, int x1, int y1, int rayon): Forme(prop), _x1(x1), _y1(y1), _rayon(rayon) {}

    std::string to_svg() const override { return ""; }
private:
    int _x1;
    int _y1;
    int _rayon;
};
