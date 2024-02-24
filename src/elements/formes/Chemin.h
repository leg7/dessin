#pragma once

#include <vector>

#include "Forme.h"

class Chemin: public Forme {
	public:
	Chemin(double x1, double y1) noexcept { _points = { Point{ x1, y1 } }; }

	virtual Type type() const noexcept override { return Type::Chemin; }
	std::string to_svg() const override;

	void ajoutePoint(double x, double y);

	protected:
		Point centre() const override;
};


