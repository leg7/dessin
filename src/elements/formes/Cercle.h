#pragma once

#include "Forme.h"

class Cercle: public Forme {
	public:
		Cercle(double x1, double y1, double rayon) noexcept: Forme(Type::Cercle), _x1(x1), _y1(y1), _rayon(rayon) {}
		Cercle(Proprietes prop, double x1, double y1, double rayon) noexcept: Forme(prop, Type::Cercle), _x1(x1), _y1(y1), _rayon(rayon) {}

		std::string to_svg() const override;
	private:
		double _x1;
		double _y1;
		double _rayon;
};
