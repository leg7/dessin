#pragma once

class Ellipse {
public:
    Ellipse(int x1, int y1, int longueur, int hauteur):
        _x1(x1), _y1(y1), _longueur(longueur), _hauteur(hauteur)
    {}

private:
    int _x1;
    int _y1;
    int _longueur;
    int _hauteur;
};
