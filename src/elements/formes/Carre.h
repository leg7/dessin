#pragma once

#include "Forme.h"

class Carre: public Forme {
	public:
		Carre(double x1, double y1, double taille) noexcept: Forme(Type::Carre), _x1(x1), _y1(y1), _taille(taille) {}
		Carre(Proprietes prop, double x1, double y1, double taille) noexcept: Forme(prop, Type::Carre), _x1(x1), _y1(y1), _taille(taille) {}

		std::string to_svg() const override { return ""; }

	private:
		double _x1;
		double _y1;
		double _taille;
};
