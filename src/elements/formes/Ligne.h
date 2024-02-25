#pragma once

#include "Forme.h"

class Ligne: public Forme {
public:
    Ligne(const std::shared_ptr<Expression> &x1,
	    const std::shared_ptr<Expression> &y1,
	    const std::shared_ptr<Expression> &x2,
	    const std::shared_ptr<Expression> &y2) noexcept { _points = {  x1, y1, x2, y2 }; }

    virtual Type type() const noexcept override { return Type::Ligne; }
    std::string to_svg() const override;

protected:
	Point centre() const override;
};

