#pragma once

#include <memory>
#include <string>
#include <vector>

#include "../Element.h"
#include "../../expressions/Expression.h"

class Forme: public Element {
public:
	enum class Propriete
	{
		Couleur,
		Remplissage,
		Opacite,
		Rotation,
		Epaisseur,
		Taille,
		Point,
	};

	static constexpr int8_t _proprietesStandardCount = 5;
	std::array<std::shared_ptr<Expression>, _proprietesStandardCount> _proprietesStandard;
	std::shared_ptr<Expression> getPropriete(Propriete p, int indexPoint = -1);

	static constexpr const char* _proprietesNoms[_proprietesStandardCount + 1] = {
		"couleur",
		"remplissage",
		"opacite",
		"rotation",
		"epaisseur",
		"taille"
	};
	static std::string nomPropriete(Propriete p) { return _proprietesNoms[static_cast<int8_t>(p)]; }

	std::vector<std::shared_ptr<Expression>> _points;

	std::shared_ptr<Expression> couleur() const noexcept { return _proprietesStandard[static_cast<int8_t>(Propriete::Couleur)]; }
	std::shared_ptr<Expression> remplissage() const noexcept { return _proprietesStandard[static_cast<int8_t>(Propriete::Remplissage)]; }
	std::shared_ptr<Expression> opacite() const noexcept { return _proprietesStandard[static_cast<int8_t>(Propriete::Opacite)]; }
	std::shared_ptr<Expression> rotation() const noexcept { return _proprietesStandard[static_cast<int8_t>(Propriete::Rotation)]; }
	std::shared_ptr<Expression> epaisseur() const noexcept { return _proprietesStandard[static_cast<int8_t>(Propriete::Epaisseur)]; }

	struct messageSetPropriete
	{
		Propriete propriete;
		std::shared_ptr<Expression> valeure;
		int8_t indexPoint;

		messageSetPropriete(Propriete p, const std::shared_ptr<Expression> &val, int8_t index = -1)
			: propriete(p), valeure(val), indexPoint(index) {}
	};
	virtual void recevoirMessage(const messageSetPropriete &m);

	virtual std::string to_svg() const = 0;
	virtual double toDouble() const noexcept override;
	virtual Type type() const noexcept override = 0;

	std::string proprietes_svg() const;

	struct Point
	{
		double x, y;
	};
	virtual Point centre() const = 0;
};
