#pragma once

#include "Forme.h"

class Rectangle: public Forme {
public:
    Rectangle(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4) noexcept: Forme(Type::Rectangle), _coordonnees { x1, y1, x2, y2, x3, y3, x4, y4 } {}
    Rectangle(Proprietes prop, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4) noexcept: Forme(prop, Type::Rectangle), _coordonnees { x1, y1, x2, y2, x3, y3, x4, y4 } {}

    std::string to_svg() const override;

private:
    int _coordonnees[8];
};
