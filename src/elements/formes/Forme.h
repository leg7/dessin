#pragma once

#include <memory>
#include <string>
#include <vector>

#include "../Couleur.h"
#include "../Element.h"

class Forme: public Element {
public:
	struct Point
	{
		double x = 0, y = 0;
	};
protected:
	Couleur _couleur;
	Couleur _remplissage;
	float _opacite = 0;
	float _rotation = 0;
	float _epaisseur = 0;
	std::vector<Point> _points;
public:
	static constexpr uint8_t enumProprieteFloatStart = 10;
	static constexpr uint8_t enumProprieteCouleurStart = 1;
	enum class Propriete: uint8_t {
		Point,
		Couleur = enumProprieteCouleurStart,
		Remplissage,
		Opacite = enumProprieteFloatStart,
		Rotation,
		Epaisseur,
		Taille,
	};
	static bool isFloatPropriete(Propriete p) noexcept { return static_cast<int>(p) >= enumProprieteFloatStart; }
	static bool isCouleurPropriete(Propriete p) noexcept;

	struct messageSetPropriete
	{
		Forme::Propriete propriete;
		union
		{
			Couleur c;
			float f;
			struct {
				double val;
				int ind;
				bool isX;
			} pointData;
		};

		messageSetPropriete(Forme::Propriete p, const Couleur &col): propriete(p), c(col) {};
		messageSetPropriete(Forme::Propriete p, const float &flt): propriete(p), f(flt) {};
		messageSetPropriete(Forme::Propriete p, double v, int i, bool x): propriete(p) { pointData.val = v; pointData.ind = i; pointData.isX = x; };
		messageSetPropriete(const messageSetPropriete &p);
	};
	void setPropriete(const messageSetPropriete &m) noexcept;

// Methodes
public:
	virtual std::string to_svg() const = 0;
	virtual double toDouble() const noexcept override;
	virtual Type type() const noexcept override = 0;
protected:
	std::string proprietes_svg() const;
	virtual Point centre() const = 0;
};

using FormePtr = std::shared_ptr<Forme>;
