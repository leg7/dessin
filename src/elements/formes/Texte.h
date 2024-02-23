#pragma once

#include <string>

#include "Forme.h"

class Texte: public Forme {
public:
    Texte(double x1, double y1, std::string const& texte, std::string const& police) noexcept: Forme(Type::Texte), _x1(x1), _y1(y1), _texte(texte), _police(police) {}
    Texte(Proprietes prop, double x1, double y1, std::string const& texte, std::string const& police) noexcept: Forme(prop, Type::Texte), _x1(x1), _y1(y1), _texte(texte), _police(police) {}

    std::string to_svg() const override;

private:
    double _x1;
    double _y1;
    std::string _texte;
    std::string _police;
};
