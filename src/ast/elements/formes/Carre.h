#pragma once

#include "Forme.h"

class Carre: public Forme {
	public:
		Carre(int x1, int y1, int taille): _x1(x1), _y1(y1), _taille(taille) {}
		Carre(Proprietes prop, int x1, int y1, int taille): Forme(prop), _x1(x1), _y1(y1), _taille(taille) {}

		std::string to_svg() const override { return ""; }

	private:
		int _x1;
		int _y1;
		int _taille;
};
