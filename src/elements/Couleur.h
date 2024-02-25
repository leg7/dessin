#pragma once
#pragma once
#include <cstdint>
#include <string>
#include "Element.h"
#include "../expressions/Expression.h"

class Couleur: public Element
{
        uint8_t _r, _g, _b;
	  std::shared_ptr<Expression> _re = nullptr, _ge = nullptr, _be = nullptr;

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

        Couleur() noexcept:  _r(0), _g(0), _b(0) {};
        Couleur(const uint8_t r, const uint8_t g, const uint8_t b) noexcept:  _r(r), _g(g), _b(b) {};
        Couleur(Nom n) noexcept;
	  Couleur(uint32_t hexa) noexcept;
	  Couleur(const std::shared_ptr<Expression> &re,
		    const std::shared_ptr<Expression> &rg,
		    const std::shared_ptr<Expression> &rb
	  ): _re(re), _ge(rg), _be(rb) {}

	  Couleur(const Couleur &c) noexcept = default;
	  Couleur& operator=(const Couleur &c) noexcept = default;
	  // TODO: operateur comparaison

	  std::string to_string() const noexcept;
	  virtual double toDouble() const noexcept override;
	  virtual Type type() const noexcept override { return Type::Couleur; }
};
