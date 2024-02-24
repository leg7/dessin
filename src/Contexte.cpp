#include "Contexte.h"
#include <memory>

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

std::shared_ptr<Forme> Contexte::addForme(const std::shared_ptr<Forme> &f) noexcept
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
