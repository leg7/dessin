#include "Contexte.h"
#include "elements/formes/Formes.h"
#include "elements/formes/Carre.h"
#include <memory>

bool Contexte::add(const std::string &nom, const std::shared_ptr<Element> &e) noexcept
{
	const auto ret = _data.insert({nom, e});
	return ret.second;
}

bool Contexte::rm(const std::string &nom) noexcept
{
	return _data.erase(nom);
}

std::shared_ptr<Carre> Contexte::getCarre(const int i) const noexcept
{
	return std::dynamic_pointer_cast<Carre>(_data.at("carre[" + std::to_string(i) + "]"));
}

std::shared_ptr<Rectangle> Contexte::getRectangle(const int i) const noexcept
{
	return std::dynamic_pointer_cast<Rectangle>(_data.at("rectangle[" + std::to_string(i) + "]"));
}

std::shared_ptr<Triangle> Contexte::getTriangle(const int i) const noexcept
{
	return std::dynamic_pointer_cast<Triangle>(_data.at("triangle[" + std::to_string(i) + "]"));
}

std::shared_ptr<Cercle> Contexte::getCercle(const int i) const noexcept
{
	return std::dynamic_pointer_cast<Cercle>(_data.at("cercle[" + std::to_string(i) + "]"));
}

std::shared_ptr<Ellipse> Contexte::getEllipse(const int i) const noexcept
{
	return std::dynamic_pointer_cast<Ellipse>(_data.at("ellipse[" + std::to_string(i) + "]"));
}

std::shared_ptr<Ligne> Contexte::getLigne(const int i) const noexcept
{
	return std::dynamic_pointer_cast<Ligne>(_data.at("ligne[" + std::to_string(i) + "]"));
}

std::shared_ptr<Chemin> Contexte::getChemin(const int i) const noexcept
{
	return std::dynamic_pointer_cast<Chemin>(_data.at("chemin[" + std::to_string(i) + "]"));
}

std::shared_ptr<Texte> Contexte::getTexte(const int i) const noexcept
{
	return std::dynamic_pointer_cast<Texte>(_data.at("texte[" + std::to_string(i) + "]"));
}
