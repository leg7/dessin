#include "Chemin.h"

#include <algorithm>

std::string Chemin::to_svg() const {
	// Un chemin n'est pas vide, par construction

	std::string result;
	std::string proprietes = proprietes_svg();

	for (size_t i = 0; i < _points.size(); i += 4) {
		result += std::string("<line ")
			+ "x1=\"" + std::to_string(_points[i]->eval()->toDouble()) + "\" "
			+ "y1=\"" + std::to_string(_points[i+1]->eval()->toDouble()) + "\" "
			+ "x2=\"" + std::to_string(_points[i+2]->eval()->toDouble()) + "\" "
			+ "y2=\"" + std::to_string(_points[i+3]->eval()->toDouble()) + "\" "
			+ proprietes
			+ "/>";
	}

	return result;
}

Forme::Point Chemin::centre() const {
	Point result = { 0, 0 };

	for (size_t i = 0; i < _points.size(); i += 2) {
		result.x += _points[i]->eval()->toDouble();
		result.y += _points[i+1]->eval()->toDouble();
	}
	return { result.x / _points.size()/2, result.y / _points.size()/2 };
}

void Chemin::ajoutePoint(const std::shared_ptr<Expression> & x, const std::shared_ptr<Expression> & y)
{
	_points.push_back(x);
	_points.push_back(y);
}

