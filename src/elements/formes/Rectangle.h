#pragma once

#include "Forme.h"

class Rectangle: public Forme {
public:
    Rectangle(const std::shared_ptr<Expression> &x1,
		  const std::shared_ptr<Expression> &y1,
		  const std::shared_ptr<Expression> &x2,
		  const std::shared_ptr<Expression> &y2,
		  const std::shared_ptr<Expression> &x3,
		  const std::shared_ptr<Expression> &y3,
		  const std::shared_ptr<Expression> &x4,
		  const std::shared_ptr<Expression> &y4) noexcept { _points = { x1, y1, x2, y2, x3, y3, x4, y4 }; }

    virtual Type type() const noexcept override { return Type::Rectangle; }
    std::string to_svg() const override;
    Point centre() const override;
};
