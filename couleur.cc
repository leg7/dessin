#include "couleur.hh"
#include <string>

Couleur::Couleur(Nom n)
{
        switch (n) {
                case Nom::Rouge: _r = 255; _g = 0; _b = 0; break;
                case Nom::Vert: _r = 0; _g = 255; _b = 0; break;
                case Nom::Bleu: _r = 0; _g = 255; _b = 255; break;
                case Nom::Jaune: _r = 205; _g = 205; _b =0; break;
                case Nom::Orange: _r = 255; _g = 150; _b = 0; break;
                case Nom::Violet: _r = 127; _g = 0; _b = 255; break;
                case Nom::Magenta: _r = 255; _g = 0; _b = 255; break;
                case Nom::Cyan: _r = 0; _g = 255; _b = 255; break;
                case Nom::Noir: _r = 0; _g = 0; _b = 0; break;
                case Nom::Blanc: _r = 255; _g = 255; _b = 255; break;
        }
}
