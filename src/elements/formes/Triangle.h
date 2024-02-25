#pragma once

#include "Forme.h"

class Triangle: public Forme {
public:
    Triangle(const std::shared_ptr<Expression> &x1,
		 const std::shared_ptr<Expression> &y1,
		 const std::shared_ptr<Expression> &longueur,
		 const std::shared_ptr<Expression> &hauteur) noexcept: _longueur(longueur), _hauteur(hauteur) { _points = { {x1, y1}}; }

    virtual Type type() const noexcept override { return Type::Triangle; }
    std::string to_svg() const override;

protected:
	Point centre() const override;

private:
    std::shared_ptr<Expression> _longueur;
    std::shared_ptr<Expression> _hauteur;
};
