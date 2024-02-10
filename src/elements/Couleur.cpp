#include "Couleur.h"
#include <cstdint>
#include <string>

Couleur::Couleur(Nom n) noexcept: Element(Type::Couleur)
{
        switch (n) {
                case Nom::Rouge:   _r = 255; _g = 0;   _b = 0; 	break;
                case Nom::Vert:    _r = 0;   _g = 255; _b = 0; 	break;
                case Nom::Bleu:    _r = 0;   _g = 255; _b = 255; 	break;
                case Nom::Jaune:   _r = 205; _g = 205; _b =0; 	break;
                case Nom::Orange:  _r = 255; _g = 150; _b = 0; 	break;
                case Nom::Violet:  _r = 127; _g = 0;   _b = 255; 	break;
                case Nom::Magenta: _r = 255; _g = 0;   _b = 255; 	break;
                case Nom::Cyan:    _r = 0;   _g = 255; _b = 255; 	break;
                case Nom::Noir:    _r = 0;   _g = 0;   _b = 0; 	break;
                case Nom::Blanc:   _r = 255; _g = 255; _b = 255; 	break;
        }
}

Couleur::Couleur(uint32_t hexa) noexcept: Element(Type::Couleur)
{
	if (hexa > 0xFFFFFF) {
		exit(69);
	}

	Couleur::Hextract h { hexa };
	_r = h.parts.r;
	_g = h.parts.g;
	_b = h.parts.b;
}
