#pragma once

#include "Forme.h"

class Cercle: public Forme {
	public:
		Cercle(double x1, double y1, double rayon) noexcept: _rayon(rayon) { _points = { {x1, y1} }; }

		virtual Type type() const noexcept override { return Type::Cercle; }
		std::string to_svg() const override;

	protected:
		Point centre() const override;

	private:
		double _rayon;
};
