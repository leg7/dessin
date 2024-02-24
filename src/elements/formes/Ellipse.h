#pragma once

#include "Forme.h"

class Ellipse: public Forme {
public:
    Ellipse(double x1, double y1, double longueur, double hauteur) noexcept: _longueur(longueur), _hauteur(hauteur) { _points = { Point{ x1, y1 } }; }

    std::string to_svg() const override;
    virtual Type type() const noexcept override { return Type::Ellipse; }

protected:
	Point centre() const override;

private:
    double _longueur;
    double _hauteur;
};
