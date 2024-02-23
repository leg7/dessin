#pragma once

#include <vector>

#include "Forme.h"

class Chemin: public Forme {
	struct Point {
		double x;
		double y;
	};

	public:
	Chemin(double x1, double y1) noexcept: Forme(Type::Chemin), _points(1, Point{ x1, y1 }) {}
	Chemin(Proprietes prop, double x1, double y1) noexcept: Forme(prop, Type::Chemin), _points(1, Point{ x1, y1 }) {}

	std::string to_svg() const override;

	void ajoutePoint(double x, double y);

	private:
	std::vector<Point> _points;
};


