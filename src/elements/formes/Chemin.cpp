#include "Chemin.h"

#include <algorithm>

std::string Chemin::to_svg() const {
	// Un chemin n'est pas vide, par construction

	std::string result;
	Point precedent = _points.front();
	std::string proprietes = proprietes_svg();

	std::for_each(++_points.begin(), _points.end(), [&result, &precedent, &proprietes] (Point const& p) {
		result += std::string("<line ")
			+ "x1=\"" + std::to_string(precedent.x) + "\" "
			+ "y1=\"" + std::to_string(precedent.y) + "\" "
			+ "x2=\"" + std::to_string(p.x) + "\" "
			+ "y2=\"" + std::to_string(p.y) + "\" "
			+ proprietes
			+ "/>";
		precedent = p;
	});

	return result;
}

Forme::Point Chemin::centre() const {
	Point result = _points.front();

	std::for_each(++_points.begin(), _points.end(), [&result] (Point const& p) {
		result.x += p.x;
		result.y += p.y;
	});

	return { result.x / _points.size(), result.y / _points.size() };
}

void Chemin::ajoutePoint(double x, double y) {
    _points.push_back(Point {x, y});
}
