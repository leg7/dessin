#pragma once

#include <memory>
#include <string>

#include "../Couleur.h"
#include "../Element.h"

// TODO: Maybe get rid of the struct and make these object attr
class Forme: public Element {
public:
    struct Proprietes {
        Couleur couleur;
        Couleur remplissage;
        uint8_t opacite = 0;
        uint16_t rotation = 0;
        uint16_t epaisseur = 0;
    };

	enum class TypePropriete {
		Couleur,
		Rotation,
		Remplissage,
		Opacite,
		Epaisseur
	};

public:
    Forme(): _prop{"none", "0", "none", "1", "1"} {}
    Forme(Proprietes const& prop): _prop{ "none", "0", "none", "1", "1" } {}
    virtual std::string to_svg() const = 0;
	virtual std::string type() const noexcept = 0;
    virtual double toDouble() const noexcept override { return 1.0; }
	void setPropriete(TypePropriete type, std::string const& valeur) { _prop[static_cast<int>(type)] = valeur; }

private:
	std::string _prop[5];
};

using FormePtr = std::shared_ptr<Forme>;
