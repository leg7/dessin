#pragma once

#include "Forme.h"

class Triangle: public Forme {
public:
    Triangle(double x1, double y1, double longueur, double hauteur) noexcept: Forme(Type::Triangle), _x1(x1), _y1(y1), _longueur(longueur), _hauteur(hauteur) {}
    Triangle(Proprietes prop, double x1, double y1, double longueur, double hauteur) noexcept: Forme(prop, Type::Triangle), _x1(x1), _y1(y1), _longueur(longueur), _hauteur(hauteur) {}

    std::string to_svg() const override;

private:
    double _x1;
    double _y1;
    double _longueur;
    double _hauteur;
};
