#pragma once
#include <map>
#include <string>
#include <memory>
#include "elements/Element.h"
#include "elements/formes/Formes.h"

class Contexte
{
	std::map<std::string, std::shared_ptr<Element>> _data;

	public:
	int nCarres = 0, nRectangles = 0, nTriangles = 0, nCercles = 0, nEllipses = 0, nLignes = 0, nChemins = 0, nTextes = 0;
	bool add(const std::string &nom, const std::shared_ptr<Element> &e) noexcept;
	bool rm(const std::string &nom) noexcept;

	std::shared_ptr<Carre> getCarre(const int i) const noexcept;
	std::shared_ptr<Rectangle> getRectangle(const int i) const noexcept;
	std::shared_ptr<Triangle> getTriangle(const int i) const noexcept;
	std::shared_ptr<Cercle> getCercle(const int i) const noexcept;
	std::shared_ptr<Ellipse> getEllipse(const int i) const noexcept;
	std::shared_ptr<Ligne> getLigne(const int i) const noexcept;
	std::shared_ptr<Chemin> getChemin(const int i) const noexcept;
	std::shared_ptr<Texte> getTexte(const int i) const noexcept;
};
