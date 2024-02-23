#pragma once

#include "Forme.h"

class Ligne: public Forme {
public:
    Ligne(double x1, double y1, double x2, double y2) noexcept: Forme(Type::Ligne), _x1(x1), _y1(y1), _x2(x2), _y2(y2) {}
    Ligne(Proprietes prop, double x1, double y1, double x2, double y2) noexcept: Forme(prop, Type::Ligne), _x1(x1), _y1(y1), _x2(x2), _y2(y2) {}

    std::string to_svg() const override;

protected:
	Point centre() const override;

private:
    double _x1;
    double _y1;
    double _x2;
    double _y2;
};

