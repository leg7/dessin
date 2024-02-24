#pragma once

#include "Forme.h"

class Ligne: public Forme {
public:
    Ligne(double x1, double y1, double x2, double y2) noexcept { _points = { { x1, y1 }, { x2, y2} }; }

    virtual Type type() const noexcept override { return Type::Ligne; }
    std::string to_svg() const override;

protected:
	Point centre() const override;
};

