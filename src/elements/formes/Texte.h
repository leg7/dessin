#pragma once

#include <string>

#include "Forme.h"

class Texte: public Forme {
public:
    Texte(const std::shared_ptr<Expression> &x1,
	    const std::shared_ptr<Expression> &y1,
	    std::string const& texte,
	    std::string const& police) noexcept: _texte(texte), _police(police) { _points = { {x1, y1}}; }

    virtual Type type() const noexcept override { return Type::Texte; }
    std::string to_svg() const override;

protected:
	Point centre() const override;

private:
    std::string _texte;
    std::string _police;
};
