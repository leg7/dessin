#include "Contexte.h"
#include <memory>
#include <stdexcept>

bool Contexte::add(const std::string &nom, const std::shared_ptr<Element> &e) noexcept
{
	if (Element::isFormeType(e->type())) {
		return false;
	}
	const auto ret = _data.insert({nom, e});
	return ret.second;
}

bool Contexte::rm(const std::string &nom) noexcept
{
	return _data.erase(nom);
}

bool Contexte::contains(const std::string &key) const noexcept
{
	return _data.contains(key);
}

std::shared_ptr<Forme> Contexte::getForme(Element::Type t, const int num) noexcept
{
	return std::dynamic_pointer_cast<Forme>(
			_data.at(std::string(Element::nomFormes[(int)t]) + std::to_string(num))
			);
}

void Contexte::addForme(const std::shared_ptr<Forme> &f) noexcept
{
	const auto tmp = static_cast<int>(f->type());
	const auto num = _compteurDeFormes[tmp]++;
	_data.insert({
		std::string(Element::nomFormes[tmp]) + std::to_string(num),
		f
	});
}

std::shared_ptr<Element> Contexte::at(const std::string key) const noexcept
{
	return _data.at(key);
}

std::shared_ptr<Forme> Contexte::atForme(const std::string key) const
{
	const auto ptr = at(key);
	if (Element::isFormeType(ptr->type())) {
		return std::dynamic_pointer_cast<Forme>(ptr);
	} else {
		throw std::invalid_argument("La variable que vous voulez n'est pas une forme");
	}
}

