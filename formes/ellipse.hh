#pragma once

#include "forme.hh"

class Ellipse: public Forme {
public:
    Ellipse(Proprietes prop, int x1, int y1, int longueur, int hauteur)
        : Forme(prop), _x1(x1), _y1(y1), _longueur(longueur), _hauteur(hauteur)
    {}

    std::string to_svg() const override { return ""; }

private:
    int _x1;
    int _y1;
    int _longueur;
    int _hauteur;
};
