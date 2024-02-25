#pragma once

#include "Forme.h"

class Ellipse: public Forme {
public:
    Ellipse(const std::shared_ptr<Expression> & x1,
		const std::shared_ptr<Expression> & y1,
		const std::shared_ptr<Expression> & longueur,
		const std::shared_ptr<Expression> & hauteur) noexcept:
	    _longueur(longueur), _hauteur(hauteur) { _points = { { x1, y1 } }; }

    std::string to_svg() const override;
    virtual Type type() const noexcept override { return Type::Ellipse; }

protected:
	Point centre() const override;

private:
    std::shared_ptr<Expression> _longueur;
    std::shared_ptr<Expression> _hauteur;
};
