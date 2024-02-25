#pragma once

#include "Forme.h"

class Carre: public Forme {
	public:
		Carre(double x1, double y1, double taille) noexcept: _taille(taille) { _points = { {x1, y1} }; }

		virtual Type type() const noexcept override { return Type::Carre; }
		std::string to_svg() const override;
		void setPropriete(const messageSetPropriete &m) noexcept;

		ElementPrimitif<double> _taille;
		Point centre() const override;
};
