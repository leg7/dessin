#pragma once

#include "Forme.h"

class Rectangle: public Forme {
public:
    Rectangle(double x1, double y1, double x2, double y2, double x3, double y3, double x4, double y4) noexcept: _coordonnees { x1, y1, x2, y2, x3, y3, x4, y4 } {}

    virtual Type type() const noexcept override { return Type::Rectangle; }
    std::string to_svg() const override;

protected:
	Point centre() const override;

private:
    double _coordonnees[8];
};
