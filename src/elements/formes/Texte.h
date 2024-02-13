#pragma once

#include <string>

#include "Forme.h"

class Texte: public Forme {
public:
    Texte(Proprietes prop, int x1, int y1, std::string const& texte, std::string const& police)
        : Forme(prop), _x1(x1), _y1(y1), _texte(texte), _police(police)
    {}

    std::string to_svg() const override { return ""; }

private:
    int _x1;
    int _y1;
    std::string _texte;
    std::string _police;
};