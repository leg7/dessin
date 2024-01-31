#pragma once

#include <string>

class Texte {
public:
    Texte(int x1, int y1, std::string const& texte, std::string const& police):
        _x1(x1), _y1(y1), _texte(texte), _police(police)
    {}

private:
    int _x1;
    int _y1;
    std::string _texte;
    std::string _police;
};
