#pragma once

#include "Forme.h"

class Triangle: public Forme {
public:
    Triangle(double x1, double y1, double longueur, double hauteur) noexcept: _longueur(longueur), _hauteur(hauteur) { _points = { {x1, y1}}; }

    virtual Type type() const noexcept override { return Type::Triangle; }
    std::string to_svg() const override;

protected:
	Point centre() const override;

private:
    double _longueur;
    double _hauteur;
};
