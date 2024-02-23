#pragma once

#include <memory>
#include <string>

#include "../Couleur.h"
#include "../Element.h"

// TODO: Maybe get rid of the struct and make these object attr
class Forme: public Element {
public:
	enum class Type: uint8_t {
		Carre,
		Cercle,
		Chemin,
		Ellipse,
		Ligne,
		Rectangle,
		Texte,
		Triangle
	};

	struct Proprietes {
		Couleur couleur;
		Couleur remplissage;
		float opacite = 0;
		float rotation = 0;
		float epaisseur = 0;
	};

	enum class TypePropriete {
		Couleur,
		Rotation,
		Remplissage,
		Opacite,
		Epaisseur
	};

public:
    Forme(Type t) noexcept;
    Forme(Proprietes const& prop, Type t) noexcept;

    virtual std::string to_svg() const = 0;
    virtual double toDouble() const noexcept override;

    void setProprietes(const Proprietes &p) noexcept;
    void setPropriete(TypePropriete type, std::string const& valeur) noexcept;
    Type type() const noexcept;

protected:
	std::string proprietes_svg() const;

private:
    Proprietes _prop;
    Type _type;
	std::string _proprietes[5];
};

using FormePtr = std::shared_ptr<Forme>;
