#pragma once
#include <cstdint>
#include <string>
#include "Element.h"

class Couleur: public Element
{
        uint8_t _r, _g, _b;

        public:
        enum class Nom
        {
                Rouge,
                Vert,
                Bleu,
                Jaune,
                Orange,
                Violet,
                Magenta,
                Cyan,
                Noir,
                Blanc
        };

	  union Hextract
	  {
		  uint32_t full;
		  struct {
			  uint8_t b;
			  uint8_t g;
			  uint8_t r;
			  uint8_t _;
		  } parts;
	  };

        Couleur(): _r(0), _g(0), _b(0) {};
        Couleur(const uint8_t r, const uint8_t g, const uint8_t b): _r(r), _g(g), _b(b) {};
        Couleur(Nom n);
	  Couleur(uint32_t hexa);
};
